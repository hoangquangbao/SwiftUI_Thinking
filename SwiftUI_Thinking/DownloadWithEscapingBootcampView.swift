//
//  DownloadWithEscapingBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/02/2023.
//

import SwiftUI

struct DownloadWithEscapingBootcampView: View {
    
    @StateObject var vm = DownloadWithEscapingBootcampViewModel()
    
    var body: some View {
        ForEach(vm.posts) { post in
            VStack(alignment: .leading, spacing: 10) {
                            Text("ID: \(post.id)")
                            Text("UserID: \(post.userId)")
                            Text(post.title)
                            Text(post.body)
                        }
                }
    }
}

struct DownloadWithEscapingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcampView()
    }
}
