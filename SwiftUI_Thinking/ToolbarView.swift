//
//  ToolbarView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 09/06/2023.
//

import SwiftUI

struct ToolbarView: View {
    var body: some View {
        NavigationStack {
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
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView()
    }
}
