//
//  ATCurveStyle.swift
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

/// Curve style for tab view.
public struct ATCurveStyle: ATBackgroundStyle {
    
    public var state: ATTabState
    public var color: Color = .white
    public var radius: CGFloat = 60
    public var depth: CGFloat = 0.95
    
    public init(_ state: ATTabState, color: Color, radius: CGFloat, depth: CGFloat) {
        self.state = state
        self.color = color
        self.radius = radius
        self.depth = depth
    }
    
    public var body: some View {
        let tabConstant = state.constant.tab
        GeometryReader { proxy in
            ATCurveShape(radius: radius, depth: depth, position: state.getCurrentDeltaX())
                .fill(color)
                .frame(height: tabConstant.normalSize.height + (state.constant.axisMode == .bottom ? state.safeAreaInsets.bottom : state.safeAreaInsets.top))
                .scaleEffect(CGSize(width: 1, height: state.constant.axisMode == .bottom ? 1 : -1))
                .mask(
                    Rectangle()
                        .frame(height: proxy.size.height + 100)
                )
                .shadow(color: tabConstant.shadow.color,
                        radius: tabConstant.shadow.radius,
                        x: tabConstant.shadow.x,
                        y: tabConstant.shadow.y)
            
        }
        
        .animation(.easeInOut, value: state.currentIndex)
    }
}
