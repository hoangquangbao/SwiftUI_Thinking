//
//  PhotoModelDataService.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 26/12/2022.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService() //Singleton
    private init() {
        downloadData()
    }
    
    @Published var photoModels: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        //MARK: - Example in reality
        /*
        //1. sign up for monthly subscription for package to be delivered
        //2. the company would make the package behind the scene
        //3. receive the package at your front door
        //4. make sure the box isn't damaged
        //5. open and make sure the item is correct
        //6. use the item!!!
        //7. cancellable at any time!!!
        */
        //MARK: - Manual
        /*
        //1. create the publisher
        //2. subscribe publisher on background thread
        //3. recieve on main thread
        //4. tryMap (check that the data is good)
        //5. decode (decode data into PostModels)
        //6. sink (put the item into out app)
        //7. store (cancel subscription if needed)
        */
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
//            .tryMap({ (data, response) -> Data in
//                guard
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode >= 200 && response.statusCode < 300
//                else { throw URLError(.badServerResponse) }
//                return data
//            })
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data. \(error)")
                }
            } receiveValue: { [weak self] returnPhotoModels in
                self?.photoModels = returnPhotoModels
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
