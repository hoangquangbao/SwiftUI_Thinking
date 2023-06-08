//
//  AsyncPublisherView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 08/06/2023.
//

import SwiftUI
import Combine

class AsyncPublisherDataManager {
    
    @Published var myData: [String] = []
    
    func addData() async {
        myData.append("Element 1")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        myData.append("Element 2")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        myData.append("Element 3")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        myData.append("Element 4")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        myData.append("Element 5")
    }
}

class AsyncPublisherViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    var dataManager = AsyncPublisherDataManager()
    var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        ///Get data using Combine
//        dataManager.$myData
//            .receive(on: DispatchQueue.main)
//            .sink { returnValue in
//                self.dataArray = returnValue
//            }
//            .store(in: &cancellable)
        
        
        ///Convert @Publisher to Async/Await
        ///Get data using Async/Await
//        Task {
//            for await value in dataManager.$myData.values {
//                await MainActor.run {
//                    self.dataArray = value
//                }
//            }
//        }
        
        ///Ta có demo nhỏ như bên dưới
        ///The "TWO" value never to print cause FOR loop alway listening for next value because it don't know when give a value from Publisher
        ///If you want to print TWO, you need use a "break" command line to mark exit loop
        
        Task {
            
            await MainActor.run {
                self.dataArray.append("ONE")
            }
            
            for await value in dataManager.$myData.values {
                await MainActor.run {
                    self.dataArray = value
                }
            }
            
            await MainActor.run {
                self.dataArray.append("TWO")
            }
        }
    }
    
    func start() async {
        await dataManager.addData()
    }
}

struct AsyncPublisherView: View {
    
    @StateObject var vm = AsyncPublisherViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(vm.dataArray, id: \.self) {
                    Text($0)
                }
            }
        }
        .task {
            await vm.start()
        }
    }
}

struct AsyncPublisherView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncPublisherView()
    }
}
