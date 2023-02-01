//
//  DownloadWithEscapingBootcampViewModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/02/2023.
//

import SwiftUI

class DownloadWithEscapingBootcampViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments") else { return }
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        
        downloadData(from: url) { data in
            if let data = data {
//                guard let newData = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
                guard let newData = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
//                    self?.posts.append(newData)
                    self?.posts = newData
                }
            } else {
                print("No data return!")
            }
        }
    }
    
    func downloadData(from url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                //Is check url response?
                let response = response as? HTTPURLResponse,
                //Check url is response with good status
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data")
                return
            }
            completionHandler(data)
//            print("SUCCESSFULLY DOWNLOADED DATA!")
//            print(data)
//            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString as Any)
        }.resume()
    }
}


//MARK: - Internet status code
/*
 Informational responses (100 – 199)
 Successful responses (200 – 299)
 Redirection messages (300 – 399)
 Client error responses (400 – 499)
 Server error responses (500 – 599)
 */
