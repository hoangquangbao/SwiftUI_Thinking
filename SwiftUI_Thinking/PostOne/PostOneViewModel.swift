//
//  PostOneViewModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/02/2023.
//

import Foundation

class PostOneViewModel: ObservableObject {
    
    @Published var posts: [PostOneModel] = []
    
    init() {
        getPost()
    }
    
    func getPost() {
        
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(url: url) { data in
            if let data = data {
                
//                guard let newData = try? JSONDecoder().decode(PostOneModel.self, from: data) else {
                guard let newDatas = try? JSONDecoder().decode([PostOneModel].self, from: data) else {
                    print("Decode data faild")
                    return
                }
                DispatchQueue.main.async {
//                    self.posts.append(newData)
                    self.posts = newDatas
                }
            } else {
                print("No data!")
            }
        }
    }
    
    func downloadData(url: URL, comletionHandle: @escaping (_ data: Data?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300,
                error == nil else {
                print("Download data error!")
                return
            }
            print("JSON Data: \(String(describing: String(data: data, encoding: .utf8)))")
            comletionHandle(data)
        }
        .resume()
    }
}
