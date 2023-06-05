//
//  TaskBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 05/06/2023.
//

import SwiftUI

class TaskBootcampViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                    print("DEBUG - image: \(Thread.current) : \(Task.currentPriority)")
                    print("DEBUG - Image: Download image successfully!")
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image2 = image
                    print("DEBUG - image2: \(Thread.current) : \(Task.currentPriority)")
                    print("DEBUG - image2: Download image successfully!")

                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcampHomeView: View {
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                TaskBootcamp()
            } label: {
                VStack {
                    Text("CLICK HERE 😇 ")
                    Text("TO TRANSFER TO NEW SCREEN")
                }
            }
        }
    }
}

struct TaskBootcamp: View {
    
    @StateObject var vm = TaskBootcampViewModel()
    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        
        VStack {
            Text("Image")
                .font(.headline)

            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 15)
                    )
            } else {
                Text("Faild to fetch image from internet!")
            }

            Divider()

            Text("Image2")
                .font(.headline)

            if let image = vm.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 15)
                    )
            } else {
                Text("Faild to fetch image from internet!")
            }
        }
        .padding()
        ///If use .task then SwiftUI will automatically cancel the task at some point after the view disappers before the action completes
        .task {
            await vm.fetchImage()
        }
//        .onDisappear(perform: {
//            fetchImageTask?.cancel()
//            print("DEBUG - Cancel successfully!")
//        })
//        .onAppear {
//            try Task.checkCancellation()
//            fetchImageTask = Task(operation: {
//                await vm.fetchImage()
//                await vm.fetchImage2()
//            })
//            /// If we handle task to download image background then use Task with hight prioriry
//            /// But we download some images from internet for next views the we can use Task with background priority for this puropose.
//            Task(priority: .high) {
//                await Task.yield()
//                print("high: \(Thread.current) : \(Task.currentPriority)")
//
//            }
//            Task(priority: .userInitiated) { print("userInitiated: \(Thread.current) : \(Task.currentPriority)") }
//            Task(priority: .medium) { print("medium: \(Thread.current) : \(Task.currentPriority)") }
//            Task(priority: .low) { print("low: \(Thread.current) : \(Task.currentPriority)") }
//            Task(priority: .utility) { print("utility: \(Thread.current) : \(Task.currentPriority)") }
//            Task(priority: .background) { print("background: \(Thread.current) : \(Task.currentPriority)") }
//        }
    }
}

struct TaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TaskBootcamp()
    }
}
