//
//  ATTabState.swift
//  AxisTabView
//
//  Created by jasu on 2022/03/09.
//  Copyright (c) 2022 jasu All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import SwiftUI

/// The current state of the tab view.
public struct ATTabState {
    
    public var constant: ATConstant
    public var itemCount: Int
    public var previousIndex: Int
    public var currentIndex: Int
    public var size: CGSize
    public var safeAreaInsets: EdgeInsets
    
    /// The current state of the tab view.
    /// - Parameters:
    ///   - constant: Defines the settings for the tab view.
    ///   - itemCount: Total number of tab buttons.
    ///   - previousIndex: The previously selected position index value.
    ///   - currentIndex: The currently selected position index value.
    ///   - size: The full size of the tab view. This also includes the safe area.
    ///   - safeAreaInsets: The safe area of the tab view.
    public init(constant: ATConstant = .init(),
                itemCount: Int = 0,
                previousIndex: Int = 0,
                currentIndex: Int = 0,
                size: CGSize = .zero,
                safeAreaInsets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)) {
        self.constant = constant
        self.itemCount = itemCount
        self.previousIndex = previousIndex
        self.currentIndex = currentIndex
        self.size = size
        self.safeAreaInsets = safeAreaInsets
    }
    
    /// Returns the position of the current tab.
    public func getCurrentX() -> CGFloat {
        let tabConstant = constant.tab
        var leadingPadding: CGFloat = 0
        
        let btnWidth: CGFloat = constant.tab.normalSize.width
        let selectBtnWidth: CGFloat = constant.tab.selectWidth > 0 ? constant.tab.selectWidth : btnWidth
        let btnAllWidth: CGFloat = constant.tab.normalSize.width * CGFloat(itemCount - 1) + selectBtnWidth
        
        let spaceAllWidth: CGFloat = size.width - btnAllWidth
        var spaceWidth: CGFloat = spaceAllWidth / CGFloat(itemCount + 1)
        
        if tabConstant.spacingMode == .center {
            spaceWidth = tabConstant.spacing
            let gap = size.width - (constant.tab.normalSize.width * CGFloat(itemCount) + (tabConstant.spacing * CGFloat(itemCount + 1)))
            leadingPadding = (gap * 0.5)
        }else {
            leadingPadding = (selectBtnWidth * 0.5 - btnWidth * 0.5)
        }
        return leadingPadding + ((spaceWidth + btnWidth) * CGFloat(currentIndex + 1) - btnWidth * 0.5) - selectBtnWidth * 0.5
    }
    
    /// Returns the percentage of the position of the current tab. A value between 0 and 1.
    public func getCurrentDeltaX() -> CGFloat {
        let selectBtnWidth: CGFloat = constant.tab.selectWidth > 0 ? constant.tab.selectWidth : constant.tab.normalSize.width
        return getCurrentX() / size.width + (selectBtnWidth * 0.5 / size.width)
    }
}
