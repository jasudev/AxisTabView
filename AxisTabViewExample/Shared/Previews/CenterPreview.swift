//
//  CenterPreview.swift
//  AxisTabViewExample
//
//  Created by jasu on 2022/03/12.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisTabView

struct CenterPreview: View {

    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    @State private var radius: CGFloat = 70
    @State private var concaveDepth: CGFloat = 0.85
    @State private var color: Color = .white
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                CustomCenterStyle(state, color: color, radius: radius, depth: concaveDepth)
            } content: {
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 0, systemName: "01.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 1, systemName: "02.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 2, systemName: "plus.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 3, systemName: "04.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
                ControllView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 4, systemName: "05.circle.fill", safeAreaTop: proxy.safeAreaInsets.top)
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
            
            VStack(alignment: .leading, spacing: 8) {
                Text("● Tab Background CurveStyle").opacity(0.5)
                HStack {
                    Text("Radius")
                    Spacer()
                    Slider(value: $radius, in: 0...100)
                    Spacer()
                    Text("\(radius, specifier: "%.2f")")
                }
                .labelsHidden()
                .padding(.leading)

                HStack {
                    Text("Concave Depth")
                    Spacer()
                    Slider(value: $concaveDepth, in: 0...0.9)
                    Spacer()
                    Text("\(concaveDepth, specifier: "%.2f")")
                }
                .labelsHidden()
                .padding(.leading)
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
    
    @State private var y: CGFloat = 0

    var content: some View {
        ZStack(alignment: .leading) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .font(.system(size: 24))
                .padding(10)
                .frame(width: systemName == "plus.circle.fill" ? 65 : 50, height: systemName == "plus.circle.fill" ? 65 : 50)
        }
        .foregroundColor(isSelection ? (systemName == "plus.circle.fill" ? Color.accentColor : Color.accentColor) :(systemName == "plus.circle.fill" ? Color.accentColor : Color.black))
        .background(systemName == "plus.circle.fill" ? Color.white : Color.clear)
        .clipShape(Capsule())
        .offset(y: positionY)
    }
    
    var body: some View {
        if constant.axisMode == .top {
            content
        }else {
            content
        }
    }
    
    private var positionY: CGFloat {
        if systemName == "plus.circle.fill" {
            return constant.axisMode == .bottom ? -20 : 20
        }
        return 0
    }
}

struct CenterPreview_Previews: PreviewProvider {
    static var previews: some View {
        CenterPreview()
    }
}
