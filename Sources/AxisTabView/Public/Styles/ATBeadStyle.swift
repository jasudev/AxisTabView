//
//  ATBeadStyle.swift
//  AxisTabView
//
//  Created by jasu on 2022/03/13.
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

/// Bead style for tab view.
public struct ATBeadStyle: ATBackgroundStyle {
    
    public var state: ATTabState
    public var color: Color
    public var cornerRadius: CGFloat
    public var marbleColor: Color
    public var radius: CGFloat
    public var depth: CGFloat
    
    @State private var y: CGFloat = 0
    @State private var alpha: CGFloat = 1
    @State private var dynamicRadius: CGFloat = 0
    @State private var dynamicDepth: CGFloat = 0
    
    public init(_ state: ATTabState, color: Color = .white, cornerRadius: CGFloat = 26, marbleColor: Color = .white, radius: CGFloat = 30, depth: CGFloat = 0.8) {
        self.state = state
        self.color = color
        self.cornerRadius = cornerRadius
        self.marbleColor = marbleColor
        self.radius = radius
        self.depth = depth
    }
    
    public var body: some View {
        let tabConstant = state.constant.tab
        ZStack(alignment: .topLeading) {
            Circle()
                .fill(marbleColor)
                .frame(width: radius * 0.5, height: radius * 0.5)
                .offset(x: state.size.width * state.getCurrentDeltaX() - (radius * 0.5) * 0.5, y: y)
                .opacity(alpha)
                .onAppear {
                    y = getCircleY()
                    alpha = 1.0
                    dynamicRadius = radius
                    dynamicDepth = depth
                }
                .onChange(of: state.currentIndex, perform: { newValue in
                    alpha = 0.0
                    withAnimation(.easeInOut(duration: 0.3)) {
                        dynamicRadius = 0
                        dynamicDepth = 0
                        y = state.constant.axisMode == .bottom ? 50 : state.constant.tab.normalSize.height + state.safeAreaInsets.top - 50
                    }
                    withAnimation(.spring(response: 0.32, dampingFraction: 0.5, blendDuration: 0.5).delay(0.2)) {
                        y = getCircleY()
                        alpha = 1.0
                    }
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.5, blendDuration: 0.5).delay(0.32)) {
                        dynamicRadius = radius
                        dynamicDepth = depth
                    }
                })
            ATCurveShape(radius: dynamicRadius, depth: dynamicDepth, position: state.getCurrentDeltaX())
                .fill(color)
                .frame(height: tabConstant.normalSize.height + (state.constant.axisMode == .bottom ? state.safeAreaInsets.bottom : state.safeAreaInsets.top))
                .scaleEffect(CGSize(width: 1, height: state.constant.axisMode == .bottom ? 1 : -1))
                .mask(RoundedRectangle(cornerRadius: cornerRadius))
                .shadow(color: tabConstant.shadow.color,
                        radius: tabConstant.shadow.radius,
                        x: tabConstant.shadow.x,
                        y: tabConstant.shadow.y)
            
        }
        .animation(.easeInOut(duration: 0.3), value: state.currentIndex)
    }
    
    private func getCircleY() -> CGFloat {
        state.constant.axisMode == .bottom ? -((radius * 0.5) * 0.3) : state.constant.tab.normalSize.height + state.safeAreaInsets.top - ((radius * 0.5) * 0.5)
    }
}

struct ATBeadStyle_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPreview()
    }
}


