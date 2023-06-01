//
//  ThrottleView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/06/2023.
//

import SwiftUI
import Combine

class ThrottleDataService {
    var passThrounghSubject = PassthroughSubject<Int, Error>()
    
    init() {
        fakeData()
    }
    
    private func fakeData() {
        var datas: [Int] = Array(1...10)
        
        for int in datas {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(int)) {
                self.passThrounghSubject.send(int)
            }
        }
    }
}

class ThrottleViewModel: ObservableObject {
    
    @Published var titiles: [String] = []
    @Published var dataService = ThrottleDataService()
    var cancellable = Set<AnyCancellable>()
    
    init() {
        getData()
    }
    
    private func getData() {
        dataService.passThrounghSubject
            .throttle(for: 5, scheduler: DispatchQueue.main, latest: false)
            .map({ String($0)})
            .sink { _ in
                
            } receiveValue: { int in
                self.titiles.append(String(int))
            }
            .store(in: &cancellable)
    }
}

struct ThrottleView: View {
    
    @StateObject var vm = ThrottleViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(vm.titiles, id: \.self) { title in
                Text(title)
                    .font(.headline)
                    .foregroundColor(.orange)
            }
        }
    }
}

struct ThrottleView_Previews: PreviewProvider {
    static var previews: some View {
        ThrottleView()
    }
}
