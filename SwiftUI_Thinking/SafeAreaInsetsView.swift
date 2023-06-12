//
//  SafeAreaInsetsView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 12/06/2023.
//

import SwiftUI

struct SafeAreaInsetsView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(1..<20) { i in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                .linearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .frame(width: 300, height: 150)
                            .onAppear {
                                print("View \(i)")
                            }
                    }
                }
            }
            .navigationTitle("Nav View")
            .safeAreaInset(edge: .top, alignment: .center, spacing: nil) {
                Image(systemName: "gear")
                    .font(.system(size: 25))
                    .frame(width: 50, height: 50)
                    .background(.yellow)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    .padding(.top)
            }
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: nil) {
                Image(systemName: "plus")
                    .font(.system(size: 35))
                    .frame(width: 50, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
        }
    }
}

struct SafeAreaInsetsView_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaInsetsView()
    }
}
