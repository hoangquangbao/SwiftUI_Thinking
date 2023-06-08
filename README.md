# NavigationStack
- The powerful tool for managing navigation and transitions in your iOS app development.
- It good more than NavigationView.
- Only available on iOS 16 or later.

#### ***Comparing NavigationView and NavigationStack***

<details>
<summary>Demo code</summary>

```
//
//  NavStackView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 08/06/2023.
//
// Have a Navigation Path that not define in this file, you can research it on the internet
import SwiftUI

struct NavStackView: View {
    var body: some View {
        
        let fruits: [String] = ["Apple", "Orange", "Banana", "Strawberry"]
        
        ///NavigationView alway init all of screen before it is to use
        ///That not good for performance of our App
//        NavigationView {
//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 40) {
//                    ForEach(1...10, id: \.self) { i in
//                        NavigationLink {
//                            MySecondScreen(i: i)
//                        } label: {
//                            Text("Click Me 🤭")
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Nav Stack")
//            .navigationDestination(for: Int.self) { i in
//                MySecondScreen(i: i)
//            }
//        }
        
        ///NavigationStack only init when it use that mean it is Lazy
        ///Should use NavigationStack rather than NavigationView
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
//                    ForEach(1...10, id: \.self) { i in
//                        NavigationLink(value: i) {
//                            Text("Click Me 🤭")
//                        }
//                    }
                    ForEach(fruits, id: \.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text("\(fruit) details")
                        }
                    }
                }
            }
            .navigationTitle("Nav Stack")
            .navigationDestination(for: Int.self) { i in
                MySecondScreen(i: i)
            }
            .navigationDestination(for: String.self) { s in
                MyThirdScreen(s: s)
            }
        }
    }
}

struct NavStackView_Previews: PreviewProvider {
    static var previews: some View {
        NavStackView()
    }
}

struct MySecondScreen: View {
    
    let i: Int
    init(i: Int) {
        self.i = i
        print("View: \(i)")
    }
    
    var body: some View {
        Text("Screen \(i)")
    }
}

struct MyThirdScreen: View {
    
    let s: String
    init(s: String) {
        self.s = s
        print("View: \(s)")
    }
    
    var body: some View {
        Text("Screen \(s)")
    }
}

```
</details>
