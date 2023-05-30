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
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        
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
            .first()
            .first(where: {  $0 > 8 })
        /// If conditionals come before then publisher emit that value
            .tryFirst(where: { int in
                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                return int > 7
            })
        
        // LAST
            .last()
            .last(where: { int in
                int > 3
            })
        /// It will through to the end of the array before return a value
            .tryLast(where: { int in
                if int == 6 {
                    throw URLError(.badServerResponse)
                }
                return int > 4
            })
        
        // DROP: Loại những value thoả điều kiện
            .dropFirst()
        /// 1
            .dropFirst(5)
        /// 6,7,8,9,10
            .drop(while: { $0 < 5 })
        /// 5,6,7,8,9,10
            .tryDrop(while: { int in
                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                return int < 8
            })
        /// printf URLError
        
        // PREFIT: Lấy những giá trị thoả điều kiện
            .prefix(6)
        /// 1,2,3,4,5,6
            .prefix(while: { $0 < 5 })
        /// 1,2,3,4
            .tryPrefix(while: { int in
                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                return int < 8
            })
        /// 1,2,3,4 and URLError
        
        // OUTPUT
            .output(at: 4)
        /// 5
            .output(in: 2...6)
        /// 3,4,5,6,7
        */
        
        //MARK: - Mathematic Operation
        /*
        // MAX
//            .max()
//            .max(by: {  $0 < $1 })
//            .tryMax(by: { int1, int2 in
//                if int1 == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return int1 < int2
//            })
        
        // MIN
//            .min()
//            .min(by: { $0 < $1 })
//            .tryMin(by: { int1, int2 in
//                if int1 == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return int1 < int2
//            })
        */

        //MARK: - Filter / Reducing Operation
        
        /*
        // MAP
//            .map({ String($0) })
//            .tryMap({ int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return String(int)
//            })
        /// It the same tryMap but in with additional we will return a value
//            .compactMap({ int in
//                if 2 < int && int <= 8 {
//                    return nil
//                }
//                return String(int)
//            })
        /// 1,2,9,10
        
        // COMPACT MAP
//            .tryCompactMap({ int in
//                if int == 3 {
//                    return nil
//                }
//
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return String(int)
//            })
        /// 1,2,4 and URLError
        
        // FILTER
//            .filter({ $0 > 5 && $0 < 9 })
        /// 6,7,8
//            .tryFilter({ int in
//                if int == 6 {
//                    throw URLError(.badServerResponse)
//                }
//                return int % 2 == 0
//            })
        /// 2,4 and URLError
        
        // REMOVE DUPLICATES
//            .removeDuplicates()
        /// 1,2,3,4,5,6,7,8,9,10
//            .removeDuplicates(by: { $0 == $1 })
        /// 1,2,3,4,5,6,7,8,9,10
//            .tryRemoveDuplicates(by: { int1, int2 in
//                if int1 < int2 {
//                    throw URLError(.badServerResponse)
//                }
//                return (int1 != 0)
//            })
        /// 1 and URLError
        
        // REPLACE
        /// Replace nil value with 5 value
//            .replaceNil(with: 5)
//            .replaceEmpty(with: 5)
        /// We can combine replace with tryMap to replace error with a default value
//            .tryMap({ int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return String(int)
//            })
//            .replaceError(with: String(7))
        /// 1,2,3,4,7
        
        // SCAN
//            .scan(3, { existingValue, newValue in
//                return existingValue + newValue
//            })
        /// We can use this two command lines below to replace for full command line above
//            .scan(3, { $0 + $1 })
//            .scan(3, +)
        /// 4,6,9,13,18,24,31,39,48,58
        
        // REDUCE
        /// It return final value after plug each value, result of the command line is 58
//            .reduce(3, { existingValue, newValue in
//                return existingValue + newValue
//            })
//            .reduce(3, +)
        
        // SATISFY
//            .allSatisfy({ $0 < 10 })
        /*
         let targetRange = (-1...100)
         let numbers = [-1, 0, 10, 5]
         numbers.publisher
             .allSatisfy { targetRange.contains($0) }
             .sink { print("\($0)") }

         // Prints: "true"
         */
//            .tryAllSatisfy({ bool in
//                if (bool != 0) {
//                    throw URLError(.badServerResponse)
//                }
//                return (bool != 0)
//            })
        
        // COLECTION
        /// Nó sẽ trả về một lúc nhiều giá trị tuỳ thuộc mình chỉ định trong collect
        /// Và ta phải đặt nó sau map khi đó mứi có tác dụng
            .map({ String($0) })
        /// Nó sẽ trả về kiểu mảng vì vậy mình có thể gán = thay về append như từng phần tử
//            .collect()
        /// Nó sẽ trả về cùng lúc 2 phần tử
//            .collect(2)
        */
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
                    break
                }
            } receiveValue: { [weak self] returnValue in
//                self?.data.append(contentsOf: returnValue)
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
