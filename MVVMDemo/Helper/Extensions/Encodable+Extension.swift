//
//  EncodableExtension.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import Foundation


extension Encodable {
    func convertToURLQueryItems() throws -> [URLQueryItem] {
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
			throw error
        }
        debugPrint("convert in query Items = \(queryItems)")
        return queryItems
    }
}
