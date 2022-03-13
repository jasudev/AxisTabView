//
//  ControlBasicView.swift
//  AxisTabViewExample
//
//  Created by jasu on 2022/03/13.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisTabView

struct ControlBasicView: View {
    
    @Binding var selection: Int
    @Binding var constant: ATConstant
    
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 8) {
                Text("● AxisMode").opacity(0.5)
                Picker(selection: $constant.axisMode) {
                    Text("Top")
                        .tag(ATAxisMode.top)
                    Text("Bottom")
                        .tag(ATAxisMode.bottom)
                } label: {
                    Text("AxisMode")
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .padding(.leading)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("● Screen Transition").opacity(0.5)
                Picker(selection: $constant.screen.transitionMode) {
                    Text("Slide")
                        .tag(ATTransitionMode.slide(50))
                    Text("Opacity")
                        .tag(ATTransitionMode.opacity)
                    Text("Scale")
                        .tag(ATTransitionMode.scale(0.90))
                    Text("None")
                        .tag(ATTransitionMode.none)
                } label: {
                    EmptyView()
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .padding(.leading)
                Toggle(isOn: $constant.screen.activeSafeArea) {
                    Text("SafeArea Toggle")
                }
                .padding(.horizontal)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("● Tab Normal Size").opacity(0.5)
                HStack {
                    Text("W").frame(width: 24, alignment: .leading)
                    Spacer()
                    Slider(value: $constant.tab.normalSize.width, in: 50...100)
                    Spacer()
                    Text("\(constant.tab.normalSize.width, specifier: "%.2f")")
                }
                .padding(.leading)
                HStack {
                    Text("H").frame(width: 24, alignment: .leading)
                    Spacer()
                    Slider(value: $constant.tab.normalSize.height, in: 50...100)
                    Spacer()
                    Text("\(constant.tab.normalSize.height, specifier: "%.2f")")
                }
                .padding(.leading)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("● Tab Select Width").opacity(0.5)
                HStack {
                    Text("W").frame(width: 24, alignment: .leading)
                    Spacer()
                    Slider(value: $constant.tab.selectWidth, in: -1...200)
                    Spacer()
                    Text("\(constant.tab.selectWidth, specifier: "%.2f")")
                    
                }
                .padding(.leading)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("● Tab Spacing").opacity(0.5)
                Picker(selection: $constant.tab.spacingMode) {
                    Text("Center")
                        .tag(ATSpacingMode.center)
                    Text("Average")
                        .tag(ATSpacingMode.average)
                } label: {
                    EmptyView()
                }
                .pickerStyle(.segmented)
                .padding(.leading)
                HStack {
                    Text("Spacing")
                    Spacer()
                    Slider(value: $constant.tab.spacing, in: 0...30)
                    Spacer()
                    Text("\(constant.tab.spacing, specifier: "%.2f")")
                }
                .disabled(constant.tab.spacingMode == .average)
                .opacity(constant.tab.spacingMode == .average ? 0.5 : 1.0)
                .padding(.leading)
            }
        }
    }
}

struct ControlBasicView_Previews: PreviewProvider {
    static var previews: some View {
        ControlBasicView(selection: .constant(1), constant: .constant(.init()))
    }
}
