//
//  BeadPreview.swift
//  AxisTabViewExample
//
//  Created by jasu on 2022/03/13.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisTabView

struct BeadPreview: View {
    
    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: true), tab: .init())
    @State private var cornerRadius: CGFloat = 26
    @State private var radius: CGFloat = 30
    @State private var depth: CGFloat = 0.8
    @State private var color: Color = .white
    @State private var marbleColor: Color = .white
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                if constant.axisMode == .bottom {
                    ATBeadStyle(state,
                                  color: color,
                                  cornerRadius: cornerRadius,
                                  marbleColor: marbleColor,
                                  radius: radius,
                                  depth: depth)
                }else {
                    ATBeadStyle(state,
                                  color: color,
                                  cornerRadius: cornerRadius,
                                  marbleColor: marbleColor,
                                  radius: radius,
                                  depth: depth)
                }
            } content: {
                ControlView(selection: $selection,
                            constant: $constant,
                            cornerRadius: $cornerRadius,
                            radius: $radius,
                            depth: $depth,
                            color: $color,
                            marbleColor: $marbleColor,
                            tag: 0,
                            systemName: "01.circle.fill",
                            safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection,
                            constant: $constant,
                            cornerRadius: $cornerRadius,
                            radius: $radius,
                            depth: $depth,
                            color: $color,
                            marbleColor: $marbleColor,
                            tag: 1,
                            systemName: "02.circle.fill",
                            safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection,
                            constant: $constant,
                            cornerRadius: $cornerRadius,
                            radius: $radius,
                            depth: $depth,
                            color: $color,
                            marbleColor: $marbleColor,
                            tag: 2,
                            systemName: "03.circle.fill",
                            safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection,
                            constant: $constant,
                            cornerRadius: $cornerRadius,
                            radius: $radius,
                            depth: $depth,
                            color: $color,
                            marbleColor: $marbleColor,
                            tag: 3,
                            systemName: "04.circle.fill",
                            safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection,
                            constant: $constant,
                            cornerRadius: $cornerRadius,
                            radius: $radius,
                            depth: $depth,
                            color: $color,
                            marbleColor: $marbleColor,
                            tag: 4,
                            systemName: "05.circle.fill",
                            safeArea: proxy.safeAreaInsets)
                
            }
        }
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: radius)
        .animation(.easeInOut, value: depth)
        .animation(.easeInOut, value: marbleColor)
        .animation(.easeInOut, value: cornerRadius)
        .navigationTitle("Screen \(selection + 1)")
    }
}

fileprivate
struct ControlView: View {
    
    @Binding var selection: Int
    @Binding var constant: ATConstant
    @Binding var cornerRadius: CGFloat
    @Binding var radius: CGFloat
    @Binding var depth: CGFloat
    @Binding var color: Color
    @Binding var marbleColor: Color
    
    let tag: Int
    let systemName: String
    let safeArea: EdgeInsets
    
    private var backgroundColor: Color {
        let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
        guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
        return colors[selection].opacity(0.2)
    }
    
    private var content: some View {
        VStack(spacing: 20) {
            ControlBasicView(selection: $selection, constant: $constant)
            VStack(alignment: .leading, spacing: 8) {
                Text("● Bead Style").opacity(0.5)
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
                    Text("Depth")
                    Spacer()
                    Slider(value: $depth, in: 0...0.8)
                    Spacer()
                    Text("\(depth, specifier: "%.2f")")
                }
                .labelsHidden()
                .padding(.leading)
                
                HStack {
                    Text("Corner Radius")
                    Spacer()
                    Slider(value: $cornerRadius, in: 0...100)
                    Spacer()
                    Text("\(cornerRadius, specifier: "%.2f")")
                }
                .labelsHidden()
                .padding(.leading)
                
                HStack {
                    Text("Color")
                    Spacer()
                    ColorPicker("", selection: $color)
                }
                .padding(.leading)
                .labelsHidden()
                
                HStack {
                    Text("Bead Color")
                    Spacer()
                    ColorPicker("", selection: $marbleColor)
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
                        .padding(.bottom, getBottomPadding())
                }
            }else {
                ScrollView {
                    content
                        .padding()
                        .padding(.top, getTopPadding())
                        .padding(.bottom, getBottomPadding())
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
        return constant.axisMode == .top ? constant.tab.normalSize.height + safeArea.top : 0
    }
    
    private func getBottomPadding() -> CGFloat {
        guard !constant.screen.activeSafeArea else { return 0 }
        return constant.axisMode == .bottom ? constant.tab.normalSize.height + safeArea.bottom : 0
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
        }
        .foregroundColor(isSelection ? Color.accentColor : Color.black)
        .clipShape(Capsule())
        .offset(y: y)
        .onAppear {
            if isSelection {
                withAnimation(.easeInOut(duration: 0.26)) {
                    y = constant.axisMode == .top ? -20 : 20
                }
                withAnimation(.easeInOut(duration: 0.3).delay(0.25)) {
                    y = constant.axisMode == .top ? -10 : 10
                }
            }else {
                y = 0
            }
        }
    }
    var body: some View {
        if constant.axisMode == .top {
            content
        }else {
            content
        }
    }
}

struct BeadPreview_Previews: PreviewProvider {
    static var previews: some View {
        BeadPreview()
    }
}
