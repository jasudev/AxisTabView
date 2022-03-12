//
//  LinePreview.swift
//  AxisTabViewExample
//
//  Created by jasu on 2022/03/12.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisTabView

struct LinePreview: View {

    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    @State private var radius: CGFloat = 76
    @State private var concaveDepth: CGFloat = 0.85
    @State private var color: Color = .white
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                CustomLineStyle(state, color: color)
            } content: {
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 0, systemName: "01.square.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 1, systemName: "02.square.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 2, systemName: "03.square.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 3, systemName: "04.square.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 4, systemName: "05.square.fill", safeAreaTop: proxy.safeAreaInsets.top)
            }
        }
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: radius)
        .animation(.easeInOut, value: concaveDepth)
        .navigationTitle("Screen \(selection + 1)")
    }
}

fileprivate
struct ControllView: View {

    @Binding var selection: Int
    @Binding var constant: ATConstant
    @Binding var radius: CGFloat
    @Binding var concaveDepth: CGFloat
    @Binding var color: Color
    
    let tag: Int
    let systemName: String
    let safeAreaTop: CGFloat
    
    private var backgroundColor: Color {
        let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
        guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
        return colors[selection].opacity(0.2)
    }
    
    private var content: some View {
        VStack(spacing: 20) {
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
                
                HStack {
                    Text("Color")
                    Spacer()
                    ColorPicker("", selection: $color)
                }
                .padding(.leading)
                .labelsHidden()
            }
        }
    }
    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
            if constant.axisMode == .bottom {
                ScrollView {
                    content
                        .padding()
                        .padding(.top, getTopPadding())
                }
            }else {
                ScrollView {
                    content
                        .padding()
                        .padding(.top, getTopPadding())
                }
            }
        }
        .tabItem(tag: tag, normal: {
            TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName)
        }, select: {
            TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName)
        })
    }
    
    private func getTopPadding() -> CGFloat {
        guard !constant.screen.activeSafeArea else { return 0 }
        return constant.axisMode == .top ? constant.tab.normalSize.height + safeAreaTop : 0
    }
}

fileprivate
struct TabButton: View {
    
    @Binding var constant: ATConstant
    @Binding var selection: Int
    
    let tag: Int
    let isSelection: Bool
    let systemName: String
    
    var content: some View {
        ZStack(alignment: .leading) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .font(.system(size: 24))
                .padding(10)

        }
        .foregroundColor(isSelection ? Color.accentColor : Color.black)
    }
    
    var body: some View {
        if constant.axisMode == .top {
            content
        }else {
            content
        }
    }
}

struct LinePreview_Previews: PreviewProvider {
    static var previews: some View {
        LinePreview()
    }
}
