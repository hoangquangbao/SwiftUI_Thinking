//
//  FuturesBootcampView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 31/05/2023.
//

import SwiftUI
import Combine

//Download with combine
//Download with @escaping Closure
//Conver @escaping Closure to Combine
//If your project does not support Publisher and Subcriber Combine the use @escaping Closure but hightly recommend use Combine framework if you can because it clear and easy to control data download from internet and API.

class FuturesBootcampViewModel: ObservableObject {
    
    @Published var title: String = "Starting title"
    let url = URL(string: "https://www.google.com")!
    var cancellables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
        
        /// Get data with Combine
//        getCombinePublisher()
        /// Get data with Future and Promise
//        getFuturePublisher()
        /// General part
//            .sink { _ in
//
//            } receiveValue: { [weak self] returnValue in
//                self?.title = returnValue
//            }
//            .store(in: &cancellables)
        
        /// Get data with @escaping Closure
//        getEscapingClosure { [weak self] returnValue, error in
//            if let error = error {
//                print("ERROR: \(error)")
//            } else {
//                self?.title =  returnValue
//            }
//        }

        doSomethingWithFuture()
            .sink { _ in
            } receiveValue: { [weak self] returnValue in
                self?.title = returnValue
            }
            .store(in: &cancellables)
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map { _ in
                return "New Value of Combine"
            }
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completionHandle: @escaping (_ returnValue: String, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { Data, response, error in
            completionHandle("New Value of Closure", nil)
        }
        .resume()
    }
    
    ///Convert @escaping Closure to Combine using Future/Promise
    func getFuturePublisher() -> Future<String, Error> {
        Future { promise in
            self.getEscapingClosure { returnValue, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnValue))
                }
            }
        }
    }
    
    
    //MARK: - Bonus
    /// In a func, if you delay a inteval before return the you must be using closure
    /// Because with normal it is return immediately
    func doSomething(completionHandle: @escaping (_ returnValue: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandle("Something new values")
        }
    }
    
    func doSomethingWithFuture() -> Future<String, Never> {
        Future { promise in
            self.doSomething { returnValue in
                promise(.success(returnValue))
            }
        }
    }
}

struct FuturesBootcampView: View {
    
    @StateObject var vm = FuturesBootcampViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

struct FuturesBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        FuturesBootcampView()
    }
}
