//
//  ToolbarView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 09/06/2023.
//

import SwiftUI

struct ToolbarView: View {
    
    @State var paths: [String] = []
    
    var body: some View {
        NavigationStack(path: $paths) {
            ScrollView(showsIndicators: false) {
                ForEach(1..<10) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.orange)
                        .frame(width: 200, height: 200)
                }
            }
            .navigationTitle("Toolbar")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.3))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "arrow.backward")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "gear")
                }
            }
//            .toolbar(.hidden, for: .navigationBar)
//            .toolbarBackground(.hidden, for: .navigationBar)
//            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self, destination: { value in
                Text("This is screen of \(value)")
            })
            .toolbarTitleMenu {
                Button("Button 1") {
                    paths.append("button 1")
                }
                Button("Button 2") {
                    paths.append("button 2")
                }
            }
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView()
    }
}
