//
//  ATTabItemModifier.swift
//  AxisTabView
//
//  Created by jasu on 2022/03/07.
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

struct ATTabItemPreferenceKey: PreferenceKey {
    
    typealias Value = [ATTabItem]
    static var defaultValue: [ATTabItem] = []
    static func reduce(value: inout [ATTabItem], nextValue: () -> [ATTabItem]) {
        value.append(contentsOf: nextValue())
    }
}

struct ATTabItemModifier<SelectionValue: Hashable, N: View, S: View>: ViewModifier {
    
    @EnvironmentObject var viewModel: ATViewModel<SelectionValue>
    @EnvironmentObject var stateViewModel: ATStateViewModel<SelectionValue>
    
    /// A tag that separates the tab view.
    var tag: SelectionValue
    
    /// The tab button view in the unselected state.
    var normal: N
    
    /// The tab button view in the selected state.
    var select: S
    
    /// Handle transition animations in the content view.
    private var transition: AnyTransition {
        switch viewModel.constant.screen.transitionMode {
        case .slide(let x): return .asymmetric(insertion: .offset(x: (stateViewModel.previousIndex < stateViewModel.indexOfTag(viewModel.selection) ? x : -x)).combined(with: .opacity), removal: .opacity)
        case .scale(let scale): return .asymmetric(insertion: .scale(scale: stateViewModel.previousSelection == nil ? 1 : scale).combined(with: .opacity), removal: .opacity)
        case .opacity: return .opacity
        case .none: return .identity
        }
    }
    
    func body(content: Content) -> some View {
        let item = ATTabItem(tag: tag, normal: AnyView(normal), select: AnyView(select))
        ZStack {
            if tag == viewModel.selection {
                content
                    .transition(transition)
                    .onAppear {
                        self.stateViewModel.previousSelection = tag
                    }
            } else {
                EmptyView()
            }
        }
        .animation(viewModel.constant.screen.animation ?? .none, value: viewModel.selection)
        .preference(key: ATTabItemPreferenceKey.self, value: [item])
    }
}
