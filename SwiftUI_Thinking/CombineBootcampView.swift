//
//  CombineBootcampView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 30/05/2023.
//

import SwiftUI
import Combine

class CombineDataService {
//    @Published var basicPublisher: String = "first publish"
//    let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")
    /// Sometime works with api then we will replacing "Never" with "Error" as below
    let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")
    
    /// That works the exact same way as the CurrentValueSubject except it don't hold starting value
    let passThrounghPublisher = PassthroughSubject<String, Error>()
    
    init() {
        publisherFakedata()
    }
    
    private func publisherFakedata() {
        
        let items = ["means", "breakfast", "launch", "dinner"]
        
        for i in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
//                self.basicPublisher = items[i]
//                self.currentValuePublisher.send(items[i])
                self.passThrounghPublisher.send(items[i])
            }
        }
    }
}

class CombineBootcampViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var dataService = CombineDataService()
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    private func addSubscriber() {
//        dataService.$basicPublisher
//        dataService.currentValuePublisher
        dataService.passThrounghPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    break
                }
            } receiveValue: { [weak self] returnValue in
                self?.data.append(returnValue)
            }
            .store(in: &cancellable)
    }
}

struct CombineBootcampView: View {
    
    @StateObject var vm = CombineBootcampViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(vm.data, id: \.self) {
                    Text($0)
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct CombineBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        CombineBootcampView()
    }
}
