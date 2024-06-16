//
//  ModelBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Bao Hoang on 7/4/24.
//

import SwiftUI

struct ModelBootcamp: View {
    
    @State var users: [String] = [
        "ABC", "DEFG", "HIJKL", "MNOP", "QRSTUV", "WXYZ", "WXYZ"
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { name in
                    HStack(spacing: 10.0) {
                        Circle()
                            .fill(.green.gradient)
                            .frame(width: 20, height: 20)
                        
                        Text(name)
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(.plain)
            .padding(.horizontal)
            .navigationTitle("Users")
        }
        .background(.purple)
    }
}

#Preview {
    ModelBootcamp()
}
