//
//  SelectedTableRow.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/22/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation
import Cocoa

class CustomSelectedTableRow: NSTableRowView {

    override func drawSelection(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            let selectionRect = NSInsetRect(self.bounds, 3, 1)
            Constants.Colors.highlightGreen.setStroke()
            Constants.Colors.highlightGreen.setFill()
            let selectionPath = NSBezierPath.init(roundedRect: selectionRect, xRadius: 4, yRadius: 4)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }
}
