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
                    NavigationLink("Basic") { BasicPreview()}
                    NavigationLink("Capsule") { CapsulePreview()}
                    NavigationLink("Material") { MaterialPreview()}
                } header: {
                    Text("Normal")
                }
                
                Section {
                    NavigationLink("Concave") { CurveConcavePreview()}
                    NavigationLink("Convex") { CurveConvexPreview()}
                    NavigationLink("Bead") { BeadPreview()}
                } header: {
                    Text("Curve")
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
