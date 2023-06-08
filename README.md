# Concurrency

This repository had funcs to download images from internet as "Download with @escaping_Closure, Combine and Async"

### **1. Download images with @escaping_closure, Combine and Async/Await***

<details>
<summary>DEMO CODE - Download images with @escaping_closure, Combine and Async/Await</summary>

```
//
//  DownloadImageAsync.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/06/2023.
//

import SwiftUI
import Combine

class DownloadImageAsyncDataManager {
    
    let url = URL(string: "https://picsum.photos/200/300")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  return nil
              }
        return image
    }
    
    func downloadImageWithEscapingClosure(completionHandle: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            let image = self.handleResponse(data: data, response: response)
            completionHandle(image, error)
        }
        .resume()
    }
    
    func downloadImageWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func downloadImageWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
}

class DownloadImageAsyncViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var error: Error? = nil
    
    var dataManager = DownloadImageAsyncDataManager()
    var cancellable = Set<AnyCancellable>()
    
    init() {
//        getDataWithEscapingClosure()
//        getDataWithCombine()
        Task {
            await getDataWithAsync()
        }
    }
    
    private func getDataWithEscapingClosure() {
        dataManager.downloadImageWithEscapingClosure { [weak self] image, error in
            DispatchQueue.main.async {
                if let image = image {
                    self?.image = image
                }
            }
        }
    }
    
    private func getDataWithCombine() {
        dataManager.downloadImageWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in

            } receiveValue: { [weak self] image in
//                DispatchQueue.main.async {
//                    self?.image = image
//                }
                /// If we add receive to confirm schedule DispatchQueue.main then
                self?.image = image
            }
            .store(in: &cancellable)
    }
    
    private func getDataWithAsync() async {
        /// With Errors thrown from here are not handled we can:
        /// 1. Use do-catch to handle
//        do {
//            let image = try await dataManager.downloadImageWithAsync()
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        } catch {
//
//        }
        /// Or try? to handle
        let image = try? await dataManager.downloadImageWithAsync()
        /// With await we don't use DispatchQueue.main to changes from background threads to main threads because (28:12 seconds). You should use MainActor.run
        await MainActor.run {
            self.image = image
        }
    }
}

struct DownloadImageAsync: View {
    
    @StateObject var vm = DownloadImageAsyncViewModel()
    
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 5)
                    )
                    .padding(.horizontal)
            } else if let error = vm.error {
                Text("Error: " + error.localizedDescription)
            }
        }
    }
}

struct DownloadImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageAsync()
    }
}

```
</details>
    
### **2. Async/Await**
- Use async keyword to mark it is async function.
- Use MainActor to changes from background threads to main thread.
    
<details>
<summary>DEMO CODE - Async/Await</summary>

```
//
//  AsyncAwaitBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 02/06/2023.
//

import SwiftUI

class AsyncAwaitBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dataArray.append("Title1: \(Thread.current)")
        }
    }
    
    func addTitl2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title2 = "Title2: \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title2)
                
                let title3 = "Title3: \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    func addAuthor() async {
        let author1 = "Author1: \(Thread.current)"
        print("Author1_Test: \(Thread.current)")
        await MainActor.run {
            self.dataArray.append(author1)
        }
        
        /// Đối với DispatchQueue nếu ta muốn delay thì sử dụng asyncAfter
        /// Đối với Await thì ta dùng Task.sleep để delay lại interval trước khi thực hiện tiếp các task khác.
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let author2 = "Author2: \(Thread.current)"
        
        await MainActor.run(body: {
            self.dataArray.append(author2)
            
            let author3 = "Author3: \(Thread.current)"
            self.dataArray.append(author3)
        })
    }
    
    func addSomething() async {
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let something1 = "Something1: \(Thread.current)"
        
        await MainActor.run(body: {
            self.dataArray.append(something1)
            
            let something2 = "Something2: \(Thread.current)"
            self.dataArray.append(something2)
        })
    }
}

struct AsyncAwaitBootcamp: View {
    
    @StateObject var vm = AsyncAwaitBootcampViewModel()
    
    var body: some View {
        List(vm.dataArray, id: \.self) { item in
            Text(item)
        }
        .onAppear {
//            vm.addTitle1()
//            vm.addTitl2()
            
            Task {
                await vm.addAuthor()
                await vm.addSomething()
                
                let finalText = "FinalText: \(Thread.current)"
                vm.dataArray.append(finalText)
            }
        }
    }
}

struct AsyncAwaitBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitBootcamp()
    }
}

```
</details>

### **3. Task_and_.task**
- If use .task then SwiftUI will automatically cancel the task at some point after the view disappers before the action completes.
    
<details>
<summary>DEMO CODE - Task_and_.task</summary>

```
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

```
</details>
    
### **4. Async_Let**
- This help download image with the same time.
- But you need repeat code download for each download.

<details>
<summary>DEMO CODE - Async_Let</summary>

```
//
//  AsynLetView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 06/06/2023.
//

import SwiftUI

struct AsynLetView: View {
    
    var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    @State var images: [UIImage] = []
    let url = URL(string: "https://picsum.photos/300")!
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Async Let")
            .onAppear {
                ///Chú ý:
                ///Tất cả các fetchImage nằm chung một Task thì
                ///- nó sẽ show ra image lâu hơn vì nó chờ cho tất cả fetchImage hoàn tất đã
                ///- Để giải quyết nó thì ta có thể:
                ///- CÁCH 1: Chia mỗi fetchImage cho mỗi Task
//                Task {
//                    do {
//                        let image1 = try await fetchImage()
//                        let image2 = try await fetchImage()
//                        let image3 = try await fetchImage()
//                        let image4 = try await fetchImage()
//
//                        self.images.append(image1)
//                        self.images.append(image2)
//                        self.images.append(image3)
//                        self.images.append(image4)
//                    } catch {
//
//                    }
//                }
                ///CÁCH 2: ...
//                Task {
//                    do {
//                        let fetchImage1 = try await fetchImage()
//                        let fetchImage2 = try await fetchImage()
//                        let fetchImage3 = try await fetchImage()
//                        let fetchImage4 = try await fetchImage()
//
//                        let (image1, image2, image3, image4) = (fetchImage1, fetchImage2, fetchImage3, fetchImage4)
//
//                        self.images.append(contentsOf: [image1, image2, image3, image4])
//
//                    } catch {
//
//                    }
//                }
                
                ///CÁCH 3: Dùng async let là tối ưu nhất. This is best way to fetchImage from internet
                Task {
                    async let fetchImage1 = fetchImage()
                    async let fetchImage2 = fetchImage()
                    async let fetchImage3 = fetchImage()
                    async let fetchImage4 = fetchImage()

                    let (image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)

                    self.images.append(contentsOf: [image1, image2, image3, image4])
                }
                ///But if we want to fetch a lot of items (ex: 50 items) the we cant use this code because it long and we have another way to do it... Looking for that way with Task Group.
            }
        }
    }
    
    func fetchImage() async throws -> UIImage {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}

struct AsynLetView_Previews: PreviewProvider {
    static var previews: some View {
        AsynLetView()
    }
}

```
</details>  
 
### **5. Task_Group**
<details>
<summary>DEMO CODE - Task_Group</summary>

```
//
//  TaskGroupView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 06/06/2023.
//

import SwiftUI

class TaskGroupDataManage {
    
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
    
    /// This func have speed download the same TaskGroup but it is need to more code.
    func fetchingImageWithAsyncLet() async throws -> [UIImage] {
        
        async let fetchImage1 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchImage2 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchImage3 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchImage4 = fetchImage(urlString: "https://picsum.photos/300")

        let (image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
        
        return Array([image1, image2, image3, image4])
    }
    
    ///This func is good way to download data from internet and it is sure short code.
    func fetchingImageWithTaskGroup() async throws -> [UIImage] {
        
        let urlStrings: [String] = [
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300"
        ]
        
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var images: [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings {
                group.addTask { try? await self.fetchImage(urlString: urlString) }
            }
            
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            
            return images
        }
    }
}

class TaskGroupViewModel: ObservableObject {
    
    @Published var images: [UIImage] = []
    var dataManager = TaskGroupDataManage()
    
    func getImage() async throws {
//        if let images = try? await dataManager.fetchingImageWithAsyncLet() {
//            await MainActor.run {
//                self.images.append(contentsOf: images)
//            }
//        }
        
        if let images = try? await dataManager.fetchingImageWithTaskGroup() {
            await MainActor.run {
                self.images.append(contentsOf: images)
            }
        }
    }
}

struct TaskGroupView: View {
    
    @StateObject var vm = TaskGroupViewModel()
    var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Task Group")
            .task {
                try? await vm.getImage()
            }
        }
    }
}

struct TaskGroupView_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroupView()
    }
}

```
</details>

### **6. Continuations**
 
<details>
<summary>DEMO CODE - Continuations</summary>

```
//
//  CheckContinuationView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 07/06/2023.
//

import SwiftUI

class CheckContinuationNetworkManager {
        
    /// Download images with Async/Await
    func fetchImageWithAsyncAwait(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw URLError(.badURL)
        }
    }
    
    /// Download images with Continuations
    func fetchImageWithContinuations(url: URL) async throws -> Data {
        return await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error as! Never)
                } else {
                    continuation.resume(throwing: URLError(.badURL) as! Never)
                }
            }
            .resume()
        }
    }
    
    /// Download images from Database
    /// @escaping Closure hard working with api
    func fetchImageFromDatabase(complitionHandle: @escaping (_ image: UIImage) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            complitionHandle(UIImage(systemName: "sun.max.fill")!)
        }
    }
    
    func fetchImageFromDatabase() async -> UIImage {
        return await withCheckedContinuation { continuation in
            fetchImageFromDatabase { image in
                continuation.resume(returning: image)
            }
        }
    }
}

class CheckContinuationViewModel: ObservableObject {
    
    @Published var image: UIImage?
    var networkManager = CheckContinuationNetworkManager()
    let urlString: String = "https://picsum.photos/1000"
    
    func getImages() async {
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            ///Fetching image with AsyncAwait
//            let data = try await networkManager.fetchImageWithAsyncAwait(url: url)
            
            ///Fetching image with Continuations
            let data = try await networkManager.fetchImageWithContinuations(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getSunImagesWithEscapingClosure() {
        networkManager.fetchImageFromDatabase { [weak self] image in
            self?.image = image
        }
    }
    
    func getSunImagesWithAsyncAwait() async {
        self.image = await networkManager.fetchImageFromDatabase()
    }
}

struct CheckContinuationView: View {
    
    @StateObject var vm = CheckContinuationViewModel()
    
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .task {
//            await vm.getImages()
//            vm.getSunImagesWithEscapingClosure()
            await vm.getSunImagesWithAsyncAwait()
        }
    }
}

struct CheckContinuationView_Previews: PreviewProvider {
    static var previews: some View {
        CheckContinuationView()
    }
}

```
</details>
  
### **7. Sendable***
- We need use Sendable because Class working on many threads diff and sharing on a head so if you code follows concurrent that can be crash. So make it become safe you should use Sendable for which class that join concurrent
- This mark a Class works on safe thread. (Struct alway subtable with Sendable because it’s a copy)

<details>
<summary>DEMO CODE - Sendable</summary>

```
//
//  SendableProtocolView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 08/06/2023.
//

import SwiftUI

///We need use Sendable because Class working on many threads diff and sharing on a head so if you code follows concurrent that can be crash. So make it become safe you should use Sendable for which class that join concurrent
actor SendableProtocolDataManager {
    
    var url: URL = URL(string: "https://picsum.photos/300")!
    
    func updateDatabase() async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)!
    }
    
    func updateData(userInfo: MyUserInfo) {

    }
    
    func updateData(userInfo: MyClassUserInfo) {
        
    }
}

/// The Sendable help struct process in safe thread
/// Variables of this struct still can change
struct MyUserInfo: Sendable {
    var name: String
}

/// The Sendable help class process in safe thread
/// But with class that inherit from another class then we need mark that class subtable Sendable is final
/// With Sendable the variable of this class can't change so we mark it let
/// OR we can mark this class is @unchecked Sendable and then variables can be mark is var
final class MyClassUserInfo: @unchecked Sendable {
    var name: String
    var queue = DispatchQueue(label: "com.MyApp.MyClassUserInfo")
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(name: String) {
        queue.async {
            self.name = name
        }
    }
}

class SendableProtocolViewModel: ObservableObject {
    
    var dataManager = SendableProtocolDataManager()
    
    var userInfo_struct = MyUserInfo(name: "USER INFO OF STRUCT")
    var userInfo_class = MyClassUserInfo(name: "USER INFO OF CLASS")
    
    func updateCurrentUserInfo() async {
        await dataManager.updateData(userInfo: userInfo_struct)
        await dataManager.updateData(userInfo: userInfo_class)
    }
}

struct SendableProtocolView: View {
    
    @StateObject var vm = SendableProtocolViewModel()
    
    var body: some View {
        
        Text("This data get from Class and Struct")
    }
}

struct SendableProtocolView_Previews: PreviewProvider {
    static var previews: some View {
        SendableProtocolView()
    }
}

```
</details>   
