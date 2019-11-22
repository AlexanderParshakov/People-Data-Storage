//
//  OnlyIntegerValueFormatter.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/22/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation

class OnlyIntegerValueFormatter: NumberFormatter {
    
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        if partialString.isEmpty {
            return true
        }
        
        if partialString.count > 3 {
            return false
        }
        return Int(partialString) != nil
    }
}
