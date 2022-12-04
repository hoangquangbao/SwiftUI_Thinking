//
//  DependencyInjectionBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 04/12/2022.
//
// https://www.youtube.com/watch?v=E3x07blYvdE&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=17&ab_channel=SwiftfulThinking

//Problem with Singletons
//1. Singleton's are global
//2. Can't custom the init!
//3. Can't swap out dependencies

//Dùng init để khởi tạo ban đầu làm cho code trở nên linh động hơn rất nhiều.

import SwiftUI
import Combine

struct PostsModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModel], Error>
}

//Final, when you need injection many dependencies then you need created new class Dependency as below
//class Dependency {
//    let dataService: DataServiceProtocol
//    init(dataService: DataServiceProtocol) {
//        self.dataService = dataService
//    }
//}

class ProductionDataService: DataServiceProtocol {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    let testData : [PostsModel]
    
    //? để ta muốn nó là kiểu option, có thể truyền vào nil. Khi truyền vào nil thì nó nhận giá trị default
    //Help me can test UI with special datas compare to default data. It's super powerful.
    init(testData: [PostsModel]?) {
        self.testData = testData ?? [
            PostsModel(userId: 1, id: 1, title: "title", body: "body"),
            PostsModel(userId: 2, id: 2, title: "title1", body: "body1")
        ]
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
        //Cannot convert return expression of type 'AnyPublisher<[PostsModel], Never>' to return type 'AnyPublisher<[PostsModel], any Error>'
        //Mock to test then never error but follow format has error. So we need .tryMap to look like faild
        //27:25
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}

class DependencyInjectionBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
//    let dataService: ProductionDataService
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadData()
    }
    
    func loadData() {
        dataService.getData()
//            .sink { _ in
//            } receiveValue: { posts in
//                self.dataArray = posts
//            }
//            .store(in: &cancellables)
            .sink { result in
                print(result.self)
            } receiveValue: { returnPosts in
                self.dataArray = returnPosts
            }
            .store(in: &cancellables)
    }
}

struct DependencyInjectionBootcamp: View {
    
    @StateObject private var viewModel: DependencyInjectionBootcampViewModel
    
    init(dataService: DataServiceProtocol) {
        _viewModel = StateObject(wrappedValue: DependencyInjectionBootcampViewModel(dataService: dataService))
    }
        
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray) { data in
                    Text(data.title)
                }
            }
        }
    }
}

struct DependencyInjectionBootcamp_Previews: PreviewProvider {
    
    static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    
//    static let dataService = MockDataService(testData: nil)
//    or
//    static let dataService = MockDataService(testData: [
//        PostsModel(userId: 2, id: 2, title: "title2", body: "body2")
//    ])
    
    static var previews: some View {
        DependencyInjectionBootcamp(dataService: dataService)
    }
}
