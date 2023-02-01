//
//  PostOneModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/02/2023.
//

import Foundation

/*
 {
 "userId": 1,
 "id": 1,
 "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
 "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto"
 }
 */

struct PostOneModel: Codable {
    let userId, id: Int
    let title, body: String
}
