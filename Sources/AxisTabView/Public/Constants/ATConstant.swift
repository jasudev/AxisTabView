//
//  ATConstant.swift
//  AxisTabView
//
//  Created by jasu on 2022/03/04.
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

/// The position mode of the tab view.
public enum ATAxisMode: Hashable {
    case top
    case bottom
}

/// Defines the settings for the tab view.
public struct ATConstant: Equatable {
    
    public var axisMode: ATAxisMode
    public var screen: ATScreenConstant
    public var tab: ATTabConstant
    
    /// Initializes `ATConstant`
    /// - Parameters:
    ///   - axisMode: The position mode of the tab view.
    ///   - screen: The mode of the transition animation in the content view.
    ///   - tab: A mode that defines the spacing between tab buttons.
    public init(axisMode: ATAxisMode = .bottom,
                screen: ATScreenConstant = .init(),
                tab: ATTabConstant = .init()) {
        self.axisMode = axisMode
        self.screen = screen
        self.tab = tab
    }
}
