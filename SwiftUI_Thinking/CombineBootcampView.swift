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
//    let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")
    
    /// That works the exact same way as the CurrentValueSubject except it don't hold starting value
    let passThrounghPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publisherFakedata()
    }
    
    private func publisherFakedata() {
        
//        let items = ["means", "breakfast", "launch", "dinner"]
        let items: [Int] = Array(1..<11)
        
        for i in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)/2) {
//                self.basicPublisher = items[i]
//                self.currentValuePublisher.send(items[i])
                self.passThrounghPublisher.send(items[i])
                
                if i == items.indices.last {
                    self.passThrounghPublisher.send(completion: .finished)
                }
            }
        }
    }
}

class CombineBootcampViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var dataService = CombineDataService()
    @Published var error: String = ""
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    private func addSubscriber() {
//        dataService.$basicPublisher
//        dataService.currentValuePublisher
        dataService.passThrounghPublisher
        
    //MARK: - Sequence Operation
        /*
        // FIRST
//            .first()
//            .first(where: {  $0 > 8 })
        /// If conditionals come before then publisher emit that value
//            .tryFirst(where: { int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 7
//            })
        
        // LAST
//            .last()
//            .last(where: { int in
//                int > 3
//            })
        /// It will through to the end of the array before return a value
//            .tryLast(where: { int in
//                if int == 6 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 4
//            })
        
        // DROP: Loại những value thoả điều kiện
//            .dropFirst()
        /// 1
//            .dropFirst(5)
        /// 6,7,8,9,10
//            .drop(while: { $0 < 5 })
        /// 5,6,7,8,9,10
//            .tryDrop(while: { int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 8
//            })
        /// printf URLError
        
        // PREFIT: Lấy những giá trị thoả điều kiện
//            .prefix(6)
        /// 1,2,3,4,5,6
//            .prefix(while: { $0 < 5 })
        /// 1,2,3,4
//            .tryPrefix(while: { int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 8
//            })
        /// 1,2,3,4 and URLError
        
        // OUTPUT
//            .output(at: 4)
        /// 5
//            .output(in: 2...6)
        /// 3,4,5,6,7
        */
        
            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
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
                
                if !vm.error.isEmpty {
                    Text(vm.error)
                        .font(.headline)
                        .foregroundColor(.red)
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
