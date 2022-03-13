//
//  ATTabConstant.swift
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

/// A mode that defines the spacing between tab buttons.
public enum ATSpacingMode: Hashable {
    case center
    case average
}

/// Defines the shadow of the tab view.
public struct ATTabConstant: Equatable {
    
    public var normalSize: CGSize
    public var selectWidth: CGFloat
    public var spacingMode: ATSpacingMode
    public var spacing: CGFloat
    public var shadow: ATShadowConstant
    public var activeVibration: Bool
    public var transition: AnyTransition
    public var animation: Animation?
    
    /// Initializes `ATTabConstant`
    /// - Parameters:
    ///   - normalSize: The default size of the tab button.
    ///   - selectWidth: The horizontal size of the selected tab button. The default value is -1, and if it is -1, it is the same as the default size.
    ///   - spacingMode: A mode that defines the spacing between tab buttons.
    ///   - spacing: Spacing between tab buttons when spacingMode is `.center`.
    ///   - shadow: The shadow of the background of the tab view.
    ///   - activeVibration: Activate the device's vibration. Only iOS is supported.
    ///   - transition: A transition when a tab is selected.
    ///   - animation: Animation when selecting a tab.
    public init(normalSize: CGSize = CGSize(width: 50, height: 50),
                selectWidth: CGFloat = -1,
                spacingMode: ATSpacingMode = .average,
                spacing: CGFloat = 0,
                shadow: ATShadowConstant = .init(),
                activeVibration: Bool = true,
                transition: AnyTransition = .opacity,
                animation: Animation? = .easeInOut(duration: 0.28)) {
        self.normalSize = normalSize
        self.selectWidth = selectWidth
        self.spacingMode = spacingMode
        self.spacing = spacing
        self.shadow = shadow
        self.activeVibration = activeVibration
        self.transition = transition
        self.animation = animation
    }
    
    public static func == (lhs: ATTabConstant, rhs: ATTabConstant) -> Bool {
        lhs.normalSize == rhs.normalSize &&
        lhs.selectWidth == rhs.selectWidth &&
        lhs.spacingMode == rhs.spacingMode &&
        lhs.spacing == rhs.spacing &&
        lhs.shadow == rhs.shadow &&
        lhs.activeVibration == rhs.activeVibration &&
        lhs.animation == rhs.animation
    }
}
