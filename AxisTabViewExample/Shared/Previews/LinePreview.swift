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
                ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 0, systemName: "01.square.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 1, systemName: "02.square.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 2, systemName: "03.square.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 3, systemName: "04.square.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 4, systemName: "05.square.fill", safeArea: proxy.safeAreaInsets)
            }
        }
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: radius)
        .animation(.easeInOut, value: concaveDepth)
        .navigationTitle("Screen \(selection + 1)")
    }
}

fileprivate
struct ControlView: View {

    @Binding var selection: Int
    @Binding var constant: ATConstant
    @Binding var radius: CGFloat
    @Binding var concaveDepth: CGFloat
    @Binding var color: Color
    
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
                Text("● Line Style").opacity(0.5).font(.caption)
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
