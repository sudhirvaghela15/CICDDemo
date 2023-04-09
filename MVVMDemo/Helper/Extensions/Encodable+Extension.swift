//
//  EncodableExtension.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import Foundation


extension Encodable {
    func convertToURLQueryItems() -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        do {
            let encoder =  try JSONEncoder().encode(self)
            
            let requestDictionary = (try? JSONSerialization.jsonObject(with: encoder, options: .allowFragments)).flatMap{$0 as? [String: Any]}
            
            requestDictionary?.forEach({ (key: String, value: Any?) in
                let _value =  "\(value ?? 0)" 
                guard _value.count != 0 else { return }
                queryItems.append(URLQueryItem(name: key, value: _value))
            })
        }
        catch(let error) {
           print("query string not decode \(error)")
//			throw error
        }
        debugPrint("convert in query Items = \(queryItems)")
        return queryItems
    }
	
	
	
	
	public func query(_ parameters: [String: Any]) -> String {
		var components: [(String, String)] = []

		for key in parameters.keys.sorted(by: <) {
			let value = parameters[key]!
			components += queryComponents(fromKey: key, value: value)
		}
		return components.map { "\($0)=\($1)" }.joined(separator: "&")
	}
	
	
	/// Creates a percent-escaped, URL encoded query string components from the given key-value pair recursively.
	///
	/// - Parameters:
	///   - key:   Key of the query component.
	///   - value: Value of the query component.
	///
	/// - Returns: The percent-escaped, URL encoded query string components.
	private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
		var components: [(String, String)] = []
		switch value {
		case let dictionary as [String: Any]:
			for (nestedKey, value) in dictionary {
				components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
			}
		case let array as [Any]:
			for (_, value) in array.enumerated() {
				components.append(contentsOf: queryComponents(fromKey: key, value: value))
			}
		case let number as NSNumber:
			if number.isBool {
				components.append((escape(key), escape(BoolEncoding.numeric.encode(value: number.boolValue))))
			} else {
				components.append((escape(key), escape("\(number)")))
			}
		case let bool as Bool:
			components.append((escape(key), escape(BoolEncoding.literal.encode(value: bool))))
		default:
			components.append((escape(key), escape("\(value)")))
		}
		return components
	}

	/// Creates a percent-escaped string following RFC 3986 for a query string key or value.
	///
	/// - Parameter string: `String` to be percent-escaped.
	///
	/// - Returns:          The percent-escaped `String`.
	public func escape(_ string: String) -> String {
		string.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) ?? string
	}
}




// MARK: -

extension NSNumber {
	fileprivate var isBool: Bool {
		// Use Obj-C type encoding to check whether the underlying type is a `Bool`, as it's guaranteed as part of
		// swift-corelibs-foundation, per [this discussion on the Swift forums](https://forums.swift.org/t/alamofire-on-linux-possible-but-not-release-ready/34553/22).
		String(cString: objCType) == "c"
	}
}


/// Configures how `Bool` parameters are encoded.
public enum BoolEncoding {
	/// Encode `true` as `1` and `false` as `0`. This is the default behavior.
	case numeric
	/// Encode `true` and `false` as string literals.
	case literal

	func encode(value: Bool) -> String {
		switch self {
		case .numeric:
			return value ? "1" : "0"
		case .literal:
			return value ? "true" : "false"
		}
	}
}



extension Array where Element == String {
	func joinedWithAmpersands() -> String {
		joined(separator: "&")
	}
}

extension CharacterSet {
	/// Creates a CharacterSet from RFC 3986 allowed characters.
	///
	/// RFC 3986 states that the following characters are "reserved" characters.
	///
	/// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
	/// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
	///
	/// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
	/// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
	/// should be percent-escaped in the query string.
	public static let afURLQueryAllowed: CharacterSet = {
		let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
		let subDelimitersToEncode = "!$&'()*+,;="
		let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
		
		return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
	}()
}

