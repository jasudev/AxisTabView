//
//  CurveConvexPreview.swift
//  AxisTabViewExample
//
//  Created by jasu on 2022/03/12.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisTabView

struct CurveConvexPreview: View {
    
    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    @State private var radius: CGFloat = 60
    @State private var convexDepth: CGFloat = -0.65
    @State private var color: Color = .white
    
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                ATCurveStyle(state, color: color, radius: radius, depth: convexDepth)
            } content: {
                ControlView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 0, systemName: "01.circle.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 1, systemName: "02.circle.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 2, systemName: "03.circle.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 3, systemName: "04.circle.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 4, systemName: "05.circle.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, convexDepth: $convexDepth, color: $color, tag: 5, systemName: "06.circle.fill", safeArea: proxy.safeAreaInsets)
            }
        }
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: radius)
        .animation(.easeInOut, value: convexDepth)
        .navigationTitle("Screen \(selection + 1)")
    }
}

fileprivate
struct ControlView: View {
    
    @Binding var selection: Int
    @Binding var constant: ATConstant
    @Binding var radius: CGFloat
    @Binding var convexDepth: CGFloat
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
                Text("● Curve Style").opacity(0.5).font(.caption)
                HStack {
                    Text("Color")
                    Spacer()
                    ColorPicker("", selection: $color)
                }
                .padding(.leading)
                .labelsHidden()
                
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
                    Text("Convex Depth")
                    Spacer()
                    Slider(value: $convexDepth, in: -0.65...0)
                    Spacer()
                    Text("\(convexDepth, specifier: "%.2f")")
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
        .foregroundColor(isSelection ? Color.white : Color.black)
        .background(isSelection ? Color.red : Color.clear)
        .clipShape(Capsule())
        .offset(y: y)
        .onAppear {
            if isSelection {
                withAnimation(.easeInOut(duration: 0.26)) {
                    y = constant.axisMode == .top ? 22 : -22
                }
                withAnimation(.easeInOut(duration: 0.3).delay(0.25)) {
                    y = constant.axisMode == .top ? 17 : -17
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

struct CurveConvexPreview_Previews: PreviewProvider {
    static var previews: some View {
        CurveConvexPreview()
    }
}
