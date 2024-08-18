//
//  ContentView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/11/2022.
//

import SwiftUI

//MARK: - @State
/// Not apply for Class
/*
class NumberOne {
    var numberOne: Int = 0
}

struct ContentView: View {
    @State var number: Int = 0
    @State var numberOne = NumberOne()
    
    var body: some View {
        VStack {
            Text("Number: \(number)")
                .font(.system(size: 30, weight: .bold, design: .monospaced))
            
            Text("NumberOne: \(numberOne.numberOne)")
                .font(.system(size: 30, weight: .bold, design: .monospaced))
            
            Button(action: {
                number += 1
            }, label: {
                Text("Button")
                    .frame(width: 100, height: 50, alignment: .center)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            
            Button("Button NumberOne") {
                numberOne.numberOne += 1
            }
        }
    }
}
*/

//MARK: - @State with Enum
/*
enum Mood {
    case happy
    case sad
    case neutral
}

struct ContentView: View {
    @State private var currentMood: Mood = .neutral

    var body: some View {
        VStack {
            Text("Current Mood:")
                .font(.system(size: 24, weight: .bold))

            Text(displayMood())
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .padding()

            HStack {
                Button(action: {
                    currentMood = .happy
                }, label: {
                    Text("Happy")
                        .frame(width: 100, height: 50, alignment: .center)
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })

                Button(action: {
                    currentMood = .sad
                }, label: {
                    Text("Sad")
                        .frame(width: 100, height: 50, alignment: .center)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })

                Button(action: {
                    currentMood = .neutral
                }, label: {
                    Text("Neutral")
                        .frame(width: 100, height: 50, alignment: .center)
                        .background(.gray)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
            }
        }
    }

    func displayMood() -> String {
        switch currentMood {
        case .happy:
            return "😊"
        case .sad:
            return "😢"
        case .neutral:
            return "😐"
        }
    }
}
*/

////MARK: - @StateObject
/*
class NumberOne: ObservableObject {
    @Published var numberOne: Int = 0
}

struct ContentView: View {
    @StateObject var numberOne = NumberOne()
    
    var body: some View {
        VStack {
            Text("NumberOne: \(numberOne.numberOne)")
                .font(.system(size: 30, weight: .bold, design: .monospaced))
            
            Button(action: {
                numberOne.numberOne += 1
            }, label: {
                Text("Button")
                    .frame(width: 100, height: 50, alignment: .center)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
        }
    }
}
*/

//MARK: - @ObservedObject
/*
class NumberOne: ObservableObject {
    @Published var numberOne: Int = 0
}

struct ContentView: View {
    @ObservedObject var numberOne = NumberOne()
    
    var body: some View {
        VStack {
            Text("NumberOne: \(numberOne.numberOne)")
                .font(.system(size: 30, weight: .bold, design: .monospaced))
            
            Button(action: {
                numberOne.numberOne += 1
            }, label: {
                Text("Button")
                    .frame(width: 100, height: 50, alignment: .center)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
        }
    }
}
*/

//MARK: - EnvironmentObject
class NumberOne: ObservableObject {
    @Published var numberOne: Int = 0
}

struct ContentView: View {
    @StateObject var numberOne = NumberOne()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("NumberOne: \(numberOne.numberOne)")
                    .font(.system(size: 30, weight: .bold, design: .monospaced))
                
                Button(action: {
                    numberOne.numberOne += 1
                }, label: {
                    Text("Button")
                        .frame(width: 100, height: 50, alignment: .center)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
                
                NavigationLink {
                    View2()
                } label: {
                    Text("Go to View2")
                }
            }
        }
        .environmentObject(numberOne)
    }
}

struct View2: View {
    
    var body: some View {
        VStack(content: {
            NavigationLink {
                View3()
            } label: {
                Text("Go to View3")
            }

        })
    }
}

struct View3: View {
    @EnvironmentObject var numberOne: NumberOne
    var body: some View {
        VStack(content: {
            Text("NumberOne: \(numberOne.numberOne)")
                .font(.system(size: 30, weight: .bold, design: .monospaced))
            
            Button(action: {
                numberOne.numberOne += 1
            }, label: {
                Text("Button")
                    .frame(width: 100, height: 50, alignment: .center)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })

        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
