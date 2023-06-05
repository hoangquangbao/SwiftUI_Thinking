//
//  AsyncAwaitBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 02/06/2023.
//

import SwiftUI

class AsyncAwaitBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dataArray.append("Title1: \(Thread.current)")
        }
    }
    
    func addTitl2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title2 = "Title2: \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title2)
                
                let title3 = "Title3: \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    func addAuthor() async {
        let author1 = "Author1: \(Thread.current)"
        print("Author1_Test: \(Thread.current)")
        await MainActor.run {
            self.dataArray.append(author1)
        }
        
        /// Đối với DispatchQueue nếu ta muốn delay thì sử dụng asyncAfter
        /// Đối với Await thì ta dùng Task.sleep để delay lại interval trước khi thực hiện tiếp các task khác.
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let author2 = "Author2: \(Thread.current)"
        
        await MainActor.run(body: {
            self.dataArray.append(author2)
            
            let author3 = "Author3: \(Thread.current)"
            self.dataArray.append(author3)
        })
    }
    
    func addSomething() async {
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let something1 = "Something1: \(Thread.current)"
        
        await MainActor.run(body: {
            self.dataArray.append(something1)
            
            let something2 = "Something2: \(Thread.current)"
            self.dataArray.append(something2)
        })
    }
}

struct AsyncAwaitBootcamp: View {
    
    @StateObject var vm = AsyncAwaitBootcampViewModel()
    
    var body: some View {
        List(vm.dataArray, id: \.self) { item in
            Text(item)
        }
        .onAppear {
//            vm.addTitle1()
//            vm.addTitl2()
            
            Task {
                await vm.addAuthor()
                await vm.addSomething()
                
                let finalText = "FinalText: \(Thread.current)"
                vm.dataArray.append(finalText)
            }
        }
    }
}

struct AsyncAwaitBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitBootcamp()
    }
}
