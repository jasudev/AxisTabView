//
//  CustomLineStyle.swift
//  AxisTabViewExample
//
//  Created by jasu on 2022/03/12.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisTabView

public struct CustomLineStyle: ATBackgroundStyle {
    
    public var state: ATTabState
    public var color: Color
    public var lineColor: Color
    
    public init(_ state: ATTabState = .init(), color: Color = .white, lineColor: Color = .accentColor) {
        self.state = state
        self.color = color
        self.lineColor = lineColor
    }
    
    public var body: some View {
        let tabConstant = state.constant.tab
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(color)
                .shadow(color: tabConstant.shadow.color,
                        radius: tabConstant.shadow.radius,
                        x: tabConstant.shadow.x,
                        y: tabConstant.shadow.y)
            
            VStack(spacing: 0) {
                if state.constant.axisMode == .bottom {
                    Spacer()
                        .frame(height: tabConstant.normalSize.height)
                }
                Capsule()
                    .foregroundColor(lineColor)
                    .frame(width: tabConstant.selectWidth > 0 ? tabConstant.selectWidth : tabConstant.normalSize.width, height: 2)
                    .offset(x: state.getCurrentX(), y: state.constant.axisMode == .bottom ? -6 : state.safeAreaInsets.top + tabConstant.normalSize.height - 6)
                    .animation(state.constant.tab.animation ?? .none, value: state.currentIndex)
                
                if state.constant.axisMode == .top {
                    Spacer()
                        .frame(height: tabConstant.normalSize.height)
                }
            }
        }
    }
}
