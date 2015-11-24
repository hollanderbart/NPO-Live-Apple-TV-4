//
//  String+Extension.swift
//  NPO Live
//
//  Created by Maurice van Breukelen on 21-11-15.
//  Copyright © 2015 Maurice van Breukelen. All rights reserved.
//

import Foundation

extension String {
    
	func sliceFrom(start: String, to: String) -> String? {
		return (rangeOfString(start)?.endIndex)
            .flatMap { sInd in
			(rangeOfString(to, range: sInd ..< endIndex)?.startIndex)
                .map { eInd in
				substringWithRange(sInd ..< eInd)
			}
		}
	}
	
    var encodeURIComponent: String? {
		return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
	}
	
    var decodeJSONUri: String {
		return self.stringByReplacingOccurrencesOfString("\\/", withString: "/")
	}
	
	subscript (i: Int) -> Character {
		get {
			let index = startIndex.advancedBy(i)
			return self[index]
		}
	}
	
	func setCharAt(index: Int, character: Character) -> String {
		if index > self.characters.count - 1 {
			return self
		}
		
		return self.subString(0, length: index) + String(character) + self.subString(index + 1, length: self.characters.count - index)
	}
	
	func subString(startIndex: Int, length: Int) -> String {
		let start = self.startIndex.advancedBy(startIndex)
		let end = self.startIndex.advancedBy(startIndex+length, limit: self.startIndex.advancedBy(self.characters.count))
        
		return self.substringWithRange(Range<String.Index>(start: start, end: end))
	}
}