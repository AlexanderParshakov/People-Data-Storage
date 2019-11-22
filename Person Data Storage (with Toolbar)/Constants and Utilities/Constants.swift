//
//  Constants.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/18/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation
import Cocoa

struct Constants {
    
    struct StoryboardIdentifiers {
        static let viewingScreen = "viewingScreen"
        static let editingScreen = "editingScreen"
        static let programInfoScreen = "programInfoScreen"
        static let sidebarScreen = "sidebarScreen"
    }
    
    struct Colors {
        private static func hexStringToUIColor (hex: String) -> NSColor {
            var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            
            if ((cString.count) != 6) {
                return NSColor.gray
            }
            
            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)
            
            return NSColor (
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        static let highlightGreen = hexStringToUIColor(hex: "#16B220")
    }
    
    static let HostUser = User(login: "AP", password: "123")
}
