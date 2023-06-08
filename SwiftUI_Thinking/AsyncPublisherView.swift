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
        dataManager.$myData
            .receive(on: DispatchQueue.main)
            .sink { returnValue in
                self.dataArray = returnValue
            }
            .store(in: &cancellable)
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
