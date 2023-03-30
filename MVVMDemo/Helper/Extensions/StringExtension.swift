//
//  UIStringExtension.swift
//  Box_MVVM
//
//  Created by sudhir on 11/06/22.
//

import UIKit


//Convert to HTML
extension String {
    /**
     **Description**
     - important: decode htm into string
     - parameter : nothing
     - returns: nothing
     */
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string
        
        return decoded ?? self
    }
    
    /**
     **Description**
     - important: Capitalize first lettere of words
     - parameter : nothing
     - returns: string
     */
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    /**
     **Description**
     - important: string convert into character's array
     - parameter : nothing
     - returns: nothing
     */
    
    var characterArray: [Character]{
        var characterArray = [Character]()
        for character in self {
            characterArray.append(character)
        }
        return characterArray
    }
    
    
    /**
      **Description**
      - important: bind regex string To predicate instance and set format.
         using evaluate compare two obj //: Find more information for [evaluate(with:substitutionVariables:)](https://developer.apple.com/documentation/foundation/nspredicate/1407759-evaluate)
  
      - parameter : nothing
      - returns: NSPredicate
     */
    var predicateExt : NSPredicate  {
        return NSPredicate(format:"SELF MATCHES %@", self)
    }
    
}
