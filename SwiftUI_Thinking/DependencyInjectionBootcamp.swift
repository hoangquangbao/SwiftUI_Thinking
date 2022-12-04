//
//  DependencyInjectionBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 04/12/2022.
//

import SwiftUI
import Combine

struct PostsModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ProductionDataService {
    
    static let instance = ProductionDataService() //Singleton
    var url: URL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class DependencyInjectionBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
    }
    
    func loadData() {
        ProductionDataService.instance.getData()
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
    
    @StateObject private var viewModel = DependencyInjectionBootcampViewModel()
        
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
    static var previews: some View {
        DependencyInjectionBootcamp()
    }
}
