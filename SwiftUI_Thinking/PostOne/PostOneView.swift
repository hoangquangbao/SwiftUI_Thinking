//
//  PostOneView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/02/2023.
//

import SwiftUI

struct PostOneView: View {
    
    @StateObject var vm = PostOneViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vm.posts, id: \.id) { post in
                VStack(alignment: .leading, spacing: 10) {
                    Text("ID: \(post.id)")
                    Text("UserID: \(post.userId)")
                    Text("Title: \(post.title)")
                    Text("Body: \(post.body)")
                }
            }
        }
    }
}

struct PostOneView_Previews: PreviewProvider {
    static var previews: some View {
        PostOneView()
    }
}
