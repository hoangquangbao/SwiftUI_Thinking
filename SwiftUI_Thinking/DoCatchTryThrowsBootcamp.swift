//
//  DoCatchTryThrowsBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/06/2023.
//

import SwiftUI

/*
 do-catch
 try
 throws
 */

class DoCatchTryThrowDataManager {
    
    let isActivate: Bool = false
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActivate {
            return ("NEW VALUE", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActivate {
            return .success("NEW VALUE")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String {
        if isActivate {
            return "NEW VALUE"
        } else {
            throw URLError(.badURL)
        }
    }
}

class DoCatchTryThrowViewModel: ObservableObject {
    
    @Published var text: String = "Starting Text"
    var dataManager = DoCatchTryThrowDataManager()
    
    func fetchTitle() {
        let returnValue = self.dataManager.getTitle()
        if let newTitle = returnValue.title {
            self.text = newTitle
        } else if let newError = returnValue.error {
            self.text = newError.localizedDescription
        }
    }
    
    func fetchTitle2() {
        let returnValue = self.dataManager.getTitle2()
        
        switch returnValue {
        case .success(let data):
            self.text = data
        case .failure(let error):
            self.text = error.localizedDescription
        }
    }
    
    func fetchTitle3() {
        do {
            self.text = try self.dataManager.getTitle3()
        } catch {
            self.text = error.localizedDescription
        }
    }
}

struct DoCatchTryThrowsBootcamp: View {
    
    @StateObject var vm = DoCatchTryThrowViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.headline)
            .foregroundColor(.blue)
            .frame(width: 300, height: 300)
            .onTapGesture {
//                vm.fetchTitle()
//                vm.fetchTitle2()
                vm.fetchTitle3()
            }
    }
}

struct DoCatchTryThrowsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchTryThrowsBootcamp()
    }
}
