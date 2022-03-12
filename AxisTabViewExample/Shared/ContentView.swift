//
//  ContentView.swift
//  AxisTabViewExample
//
//  Created by jasu on 2022/03/03.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
#if os(iOS)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange ]
#endif
    }
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink("BasicStyle") { BasicPreview()}
                    NavigationLink("CapsuleStyle") { CapsulePreview()}
                    NavigationLink("MaterialStyle") { MaterialPreview()}
                } header: {
                    Text("Normal")
                }
                
                Section {
                    NavigationLink("Concave") { CurveConcavePreview()}
                    NavigationLink("Convex") { CurveConvexPreview()}
                } header: {
                    Text("CurveStyle")
                }
                
                Section {
                    NavigationLink("Center") { CenterPreview()}
                    NavigationLink("Line") { LinePreview()}
                } header: {
                    Text("Custom")
                }
            }
            .navigationTitle(Text("AxisTabView"))
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
#if os(iOS)
        .navigationViewStyle(.stack)
#endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
