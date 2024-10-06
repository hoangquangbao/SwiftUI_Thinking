//
//  ContentView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/11/2022.
//
//https://youtu.be/bW7N8ACCc6A?list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO

import SwiftUI

struct ContentView: View {
    
    @State var isShowPopover: Bool = false
    @State var selectedOption: String = "Tap me"
    @State var options: [String] = [
        "Sun ☀️",
        "Cloud 🌤️",
        "Rain 🌧️"
    ]
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.2)
                .ignoresSafeArea()
            
            Button(selectedOption) {
                isShowPopover.toggle()
            }
//            .popover(isPresented: $isShowPopover) {
//                Text("Show Popover")
//                    .presentationCompactAdaptation(.sheet)
//                    .onTapGesture {
//                        isShowPopover.toggle()
//                    }
//            }
            .padding(20)
            .font(.headline)
            .foregroundStyle(.white)
            .background(content: {
                RoundedRectangle(cornerRadius: 6)
                    .fill(.blue)
            })
            .popover(isPresented: $isShowPopover, attachmentAnchor: .point(.bottom)) {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(options, id: \.self) { opt in
                            Button {
                                selectedOption = opt
                                isShowPopover.toggle()
                            } label: {
                                Text(opt)
                                    .font(.headline)
                            }
                            
                            if opt != options.last {
                                Divider()
                            }
                        }
                    }
                    .padding(15)
                    .presentationCompactAdaptation(.popover)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
