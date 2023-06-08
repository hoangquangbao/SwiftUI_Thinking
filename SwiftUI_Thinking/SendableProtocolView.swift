//
//  SendableProtocolView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 08/06/2023.
//

import SwiftUI

///We need use Sendable because Class working on many threads diff and sharing on a head so if you code follows concurrent that can be crash. So make it become safe you should use Sendable for which class that join concurrent
actor SendableProtocolDataManager {
    
    var url: URL = URL(string: "https://picsum.photos/300")!
    
    func updateDatabase() async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)!
    }
    
    func updateData(userInfo: MyUserInfo) {

    }
    
    func updateData(userInfo: MyClassUserInfo) {
        
    }
}

/// The Sendable help struct process in safe thread
/// Variables of this struct still can change
struct MyUserInfo: Sendable {
    var name: String
}

/// The Sendable help class process in safe thread
/// But with class that inherit from another class then we need mark that class subtable Sendable is final
/// With Sendable the variable of this class can't change so we mark it let
/// OR we can mark this class is @unchecked Sendable and then variables can be mark is var
final class MyClassUserInfo: @unchecked Sendable {
    var name: String
    var queue = DispatchQueue(label: "com.MyApp.MyClassUserInfo")
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(name: String) {
        queue.async {
            self.name = name
        }
    }
}

class SendableProtocolViewModel: ObservableObject {
    
    var dataManager = SendableProtocolDataManager()
    
    var userInfo_struct = MyUserInfo(name: "USER INFO OF STRUCT")
    var userInfo_class = MyClassUserInfo(name: "USER INFO OF CLASS")
    
    func updateCurrentUserInfo() async {
        await dataManager.updateData(userInfo: userInfo_struct)
        await dataManager.updateData(userInfo: userInfo_class)
    }
}

struct SendableProtocolView: View {
    
    @StateObject var vm = SendableProtocolViewModel()
    
    var body: some View {
        
        Text("This data get from Class and Struct")
    }
}

struct SendableProtocolView_Previews: PreviewProvider {
    static var previews: some View {
        SendableProtocolView()
    }
}
