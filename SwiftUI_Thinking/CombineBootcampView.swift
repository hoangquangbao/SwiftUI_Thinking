//
//  CombineBootcampView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 30/05/2023.
//

import SwiftUI
import Combine

class CombineDataService {
    @Published var basicPublisher: [String] = []
    
    init() {
        publisherFakedata()
    }
    
    private func publisherFakedata() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.basicPublisher = ["means", "breakfast", "launch", "dinner"]
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
        dataService.$basicPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    break
                }
            } receiveValue: { [weak self] returnValue in
                self?.data = returnValue
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
