//
//  AsyncAwaitBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/11/2022.
//

import SwiftUI

class AsyncAwaitBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addTitle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = ("Title \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray.append(title)
            }
        }
    }
}

struct AsyncAwaitBootcamp: View {
    
    @StateObject private var viewModel = AsyncAwaitBootcampViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
            viewModel.addTitle2()
        }
    }
}

struct AsyncAwaitBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitBootcamp()
    }
}
