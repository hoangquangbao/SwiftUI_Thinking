//
//  SubscriberBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 26/12/2022.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    @Published var count: Int = 0
    @Published var text: String = ""
    @Published var textIsValid: Bool = false
    @Published var isShowButton: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    
    
    init() {
        setUpTimer()
        addTextfieldSubscriber()
        addButtonSubscriber()
    }
    
    //MARK: - Normal Subscriber
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
                
                
                ///To cancel a array
                //                if self.count == 5 {
                //                    for item in self.cancellables {
                //                        item.cancel()
                //                    }
                //                }
                
                ///To cancel a single publisher then I should declared a variable as "var time: AnyCancellable?"
                /// To clear you should seen video: https://www.youtube.com/watch?v=Q-1EDHXUunI&list=PLwvDm4VfkdpiagxAXCT33Rkwnc5IVhTar&index=26&ab_channel=SwiftfulThinking
            }
            .store(in: &cancellables)
    }
    
    
    //MARK: - .sink is better .assign
    func addTextfieldSubscriber() {
        $text
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
        //            .map { text -> Bool in
        //             or
            .map { text in
                return text.count > 3
            }
        ///Not recommend using because there is no way to set [weak self]. Should use sink
        //            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] result in
                self?.textIsValid = result
            })
            .store(in: &cancellables)
    }
    
    //MARK: - Combine 2 Publisher
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                
                self.isShowButton = isValid && count > 6
                //                if isValid && count > 6 {
                //                    self.isShowButton = true
                //                } else {
                //                    self.isShowButton = false
                //                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        ZStack {
            
            RadialGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.purple]),
                center: .center,
                startRadius: 5,
                endRadius: 400)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("\(vm.count)")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(vm.textIsValid.description)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                TextField("Type something here...", text: $vm.text)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay (
                        ZStack {
                            Image(systemName: "xmark")
                                .frame(width: 24, height: 24)
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                                .opacity(
                                    vm.text.count < 1 ? 0.0 :
                                        vm.textIsValid ? 0.0 : 1.0
                                )
                            
                            Image(systemName: "checkmark")
                                .frame(width: 24, height: 24)
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                                .opacity(
                                    vm.textIsValid ? 1.0 : 0.0
                                )
                        }
                            .padding(.trailing)
                        ,alignment: .trailing
                    )
                
                Button {
                    
                } label: {
                    Text("Submit")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .opacity(vm.isShowButton ? 1.0 : 0.5)
                }
                .disabled(!vm.isShowButton)
            }
            .padding()
        }
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
