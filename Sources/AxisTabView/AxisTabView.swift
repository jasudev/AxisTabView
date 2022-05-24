//
//  AxisTabView.swift
//  AxisTabView
//
//  Created by jasu on 2022/03/12.
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

public struct AxisTabView<SelectionValue, Background, Content> : View where SelectionValue : Hashable, Background : View, Content : View {
    
    @StateObject private var stateViewModel: ATStateViewModel<SelectionValue> = .init()
    private let viewModel: ATViewModel<SelectionValue>
    private var selection: Binding<SelectionValue> { Binding(
        get: { self.viewModel.selection },
        set: {
            self.onTapReceive?($0)
            self.viewModel.selection = $0
        })
    }
    
    /// Defines the settings for the tab view.
    private let constant: ATConstant
    
    /// The style of the background view.
    public var background: ((ATTabState) -> Background)
    public var content:  () -> Content
    public var onTapReceive: ((SelectionValue) -> Void)?
    
    public var body: some View {
        GeometryReader { proxy in
            if proxy.size != .zero {
                ZStack {
                    Color.clear
                    content()
                        .padding(edgeSet, constant.screen.activeSafeArea ? constant.tab.normalSize.height + getSafeArea(proxy) : 0)
                }
                .overlayPreferenceValue(ATTabItemPreferenceKey.self) { items in
                    if !items.isEmpty {
                        let items = items.prefix(getLimitItemCount(size: proxy.size, itemCount: items.count))
                        let state = ATTabState(constant: constant, itemCount: items.count, previousIndex: stateViewModel.previousIndex, currentIndex: stateViewModel.indexOfTag(selection.wrappedValue), size: proxy.size, safeAreaInsets: proxy.safeAreaInsets)
                        VStack(spacing: 0) {
                            if constant.axisMode == .bottom {
                                Spacer()
                            }
                            getTabContent(Array(items))
                                .frame(width: proxy.size.width, height: constant.tab.normalSize.height)
                                .padding(edgeSet, getSafeArea(proxy))
                                .animation(constant.tab.animation ?? .none, value: self.selection.wrappedValue)
                                .background(background(state))
                            if constant.axisMode == .top {
                                Spacer()
                            }
                        }
                    }else {
                        EmptyView()
                    }
                }
                .edgesIgnoringSafeArea(edgeSet)
            }
        }
        .environmentObject(viewModel)
        .environmentObject(stateViewModel)
    }
    
    //MARK: - Properties
    private var edgeSet: Edge.Set {
        constant.axisMode == .bottom ? .bottom : .top
    }
    
    //MARK: - Methods
    private func getItemWidth(tag: SelectionValue) -> CGFloat {
        if tag == self.selection.wrappedValue {
            if constant.tab.selectWidth > 0 {
                return constant.tab.selectWidth
            }
        }
        return constant.tab.normalSize.width
    }
    
    private func getTabContent(_ items: [ATTabItem]) -> some View {
        HStack(alignment: constant.axisMode == .bottom ? .top : .bottom, spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                if constant.tab.spacingMode == .center {
                    ZStack {
                        if item.tag as! SelectionValue == self.selection.wrappedValue {
                            item.select
                                .transition(constant.tab.transition)
                        }else {
                            item.normal
                                .transition(constant.tab.transition)
                        }
                    }
                    .frame(width: getItemWidth(tag: item.tag as! SelectionValue),
                           height: constant.tab.normalSize.height)
                    .onTapGesture {
                        if let tag = item.tag as? SelectionValue {
                            self.selection.wrappedValue = tag
                            if constant.tab.activeVibration { vibration() }
                        }
                    }
                    if index != items.count - 1 {
                        Spacer().frame(width: constant.tab.spacing)
                    }
                }else {
                    Spacer()
                    ZStack {
                        if item.tag as! SelectionValue == self.selection.wrappedValue {
                            item.select
                                .transition(constant.tab.transition)
                        }else {
                            item.normal
                                .transition(constant.tab.transition)
                        }
                    }
                    .frame(width: getItemWidth(tag: item.tag as! SelectionValue),
                           height: constant.tab.normalSize.height)
                    .onTapGesture {
                        if let tag = item.tag as? SelectionValue {
                            self.selection.wrappedValue = tag
                            if constant.tab.activeVibration { vibration() }
                        }
                    }
                    if index == items.count - 1 {
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            stateViewModel.tags = items.map{ $0.tag as! SelectionValue }
        }
    }
    
    /// Returns the maximum number of tab buttons that can be displayed in the tab view.
    /// - Parameter size: The total size of the tab view.
    /// - Returns: -
    private func getLimitItemCount(size: CGSize, itemCount: Int) -> Int {
        guard itemCount > 0 else { return 0 }
        let total = size.width - (constant.tab.selectWidth > 0 ? constant.tab.selectWidth : constant.tab.normalSize.width)
        let value = Int(total * 0.85 / constant.tab.normalSize.width) + 1
        return value < 0 ? 0 : value
    }
    
    /// Returns the safe area value according to the axisMode.
    /// - Parameter proxy: Geometry proxy
    /// - Returns: -
    private func getSafeArea(_ proxy: GeometryProxy) -> CGFloat {
        constant.axisMode == .bottom ? proxy.safeAreaInsets.bottom : proxy.safeAreaInsets.top
    }
    
#if os(iOS)
    /// The device generates vibrations.
    /// - Parameter style: Vibration style.
    private func vibration(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let feedback = UIImpactFeedbackGenerator(style: style)
        feedback.prepare()
        feedback.impactOccurred()
    }
#else
    private func vibration() {}
#endif
}

public extension AxisTabView where SelectionValue: Hashable, Background: View, Content: View {
    
    /// Initializes `AxisTabView`.
    /// - Parameters:
    ///   - selection: Creates an instance that selects from content associated with Selection values.
    ///   - constant: Defines the settings for the tab view.
    ///   - background: The style of the background view.
    ///   - content: Content views with tab items applied.
    ///   - onTapReceive: Method that treats the currently selected tab as imperative syntax.
    init(selection: Binding<SelectionValue>, constant: ATConstant = .init(), @ViewBuilder background: @escaping (ATTabState) -> Background, @ViewBuilder content: @escaping () -> Content, onTapReceive: ((SelectionValue) -> Void)? = nil) {
        self.viewModel = ATViewModel(selection: selection, constant: constant)
        self.background = background
        self.constant = constant
        self.content = content
        self.onTapReceive = onTapReceive
    }
}

struct AxisTabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPreview()
    }
}


