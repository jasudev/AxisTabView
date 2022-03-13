//
//  TabViewPreview.swift
//  AxisTabView
//
//  Created by jasu on 2022/03/04.
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

/// A preview screen for testing.
struct TabViewPreview: View {
    
    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .top, tab: .init())
    
    init() {}
    var body: some View {
        AxisTabView(selection: $selection, constant: ATConstant(axisMode: .bottom)) { state in
            ATBeadStyle(state, color: .accentColor, marbleColor: Color.orange)
//            ATCurveStyle(state, color: .blue, radius: 60, depth: -0.65)
        } content: {
            Text("Tab 1")
                .tabItem(tag: 0, normal: {
                    Text("Tab 1")
                }, select: {
                    Text("Tab 1")
                        .bold()
                        .foregroundColor(Color.orange)
                })
            Text("Tab 2")
                .tabItem(tag: 1, normal: {
                    Text("Tab 2")
                }, select: {
                    Text("Tab 2")
                        .bold()
                        .foregroundColor(Color.orange)
                })
            Text("Tab 3")
                .tabItem(tag: 2, normal: {
                    Text("Tab 3")
                }, select: {
                    Text("Tab 3")
                        .bold()
                        .foregroundColor(Color.orange)
                })
            Text("Tab 4")
                .tabItem(tag: 3, normal: {
                    Text("Tab 4")
                }, select: {
                    Text("Tab 4")
                        .bold()
                        .foregroundColor(Color.orange)
                })
            Text("Tab 5")
                .tabItem(tag: 4, normal: {
                    Text("Tab 5")
                }, select: {
                    Text("Tab 5")
                        .bold()
                        .foregroundColor(Color.orange)
                })
        }
    }
}

fileprivate
struct TabButton: View {
    
    let isSelection: Bool
    let systemName: String
    @State private var y: CGFloat = -1
    
    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: 24))
            .padding(12)
            .foregroundColor(isSelection ? Color.white : Color.black)
            .background(isSelection ? Color.red : Color.clear)
            .clipShape(Circle())
            .offset(y: y)
            .onAppear {
                if isSelection {
                    y = -45
                    DispatchQueue.main.async {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.6)) {
                            y = 12
                        }
                    }
                }else {
                    y = 0
                }
            }
    }
}

struct TabViewPreview_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPreview()
    }
}
