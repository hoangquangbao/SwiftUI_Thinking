//
//  ArrayBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 10/12/2022.
//

import SwiftUI

struct UserModel: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var point: Int
    var isVeryfield: Bool
}

protocol UserDataProtocol {
    func initData() -> [UserModel]
}

class UserDataService: UserDataProtocol {
    func initData() -> [UserModel] {
        
        var dataArray: [UserModel] = []
        
        let user1 = UserModel(name: "Huy", point: 14, isVeryfield: true)
        let user2 = UserModel(name: "Luu", point: 43, isVeryfield: true)
        let user3 = UserModel(name: "Hieu", point: 23, isVeryfield: false)
        let user4 = UserModel(name: "Tuy", point: 17, isVeryfield: true)
        let user5 = UserModel(name: "Tren", point: 24, isVeryfield: false)
        let user6 = UserModel(name: "Bao", point: 33, isVeryfield: true)
        let user7 = UserModel(name: "Linda", point: 9, isVeryfield: true)
        let user8 = UserModel(name: "Tony", point: 12, isVeryfield: false)
        let user9 = UserModel(name: "Jame", point: 56, isVeryfield: false)
        let user10 = UserModel(name: "Peter", point: 77, isVeryfield: true)
        
        dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5, user6, user7, user8, user9, user10
        ])
        
        return dataArray
    }
}

class ArrayBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    var userdata: UserDataProtocol
    
    init(userdata: UserDataProtocol) {
        self.userdata = userdata
        getData()
        updateFilteredArray()
    }
    
    func getData() {
        dataArray.append(contentsOf: userdata.initData())
    }
    
    //map
    func updateFilteredArray() {
        
        // sort
//        filteredArray = dataArray.sorted(by: { (u1, u2) in u1.point > u2.point })
//        filteredArray = dataArray.sorted(by: { $0.point > $1.point })
        
        // filter
//        filteredArray = dataArray.filter({ $0.point > 30 })
//        filteredArray = dataArray.filter({ $0.isVeryfield })
        filteredArray = dataArray.filter({ $0.name.contains("u") })
    }
}

struct ArrayBootcamp: View {
    
    @StateObject var viewModel: ArrayBootcampViewModel
    
    init(userdata: UserDataProtocol) {
        _viewModel = StateObject(wrappedValue: ArrayBootcampViewModel(userdata: userdata))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.filteredArray) { user in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(user.name)
                            .font(.headline)
                        
                        HStack {
                            Text("Point: \(user.point)")
                            Spacer()
                            if user.isVeryfield {
                                Text("🌽")
                            }
                        }
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct ArrayBootcamp_Previews: PreviewProvider {
    
    static var userdata: UserDataProtocol = UserDataService()
    
    static var previews: some View {
        ArrayBootcamp(userdata: userdata)
    }
}
