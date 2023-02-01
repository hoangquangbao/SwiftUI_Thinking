//
//  CommentModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/02/2023.
//

import Foundation

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

//struct CommentModel: Identifiable, Codable {
//    let postId: Int
//    let id: Int
//    let name: String
//    let email: String
//    let body: String
//}


//struct CommentModel: Codable {
//    let postID, id: Int
//    let name, email, body: String
//
//    enum CodingKeys: String, CodingKey {
//        case postID
//        case id, name, email, body
//    }
//}
