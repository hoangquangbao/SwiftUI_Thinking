//
//  WeatherViewModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/02/2023.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    
//    @Published var weatherData: [WeatherModel] = []
//    @Published var weatherData1: WeatherModel?
    @Published var listData: [List] = []
    @Published var cityData: City?
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=13.7667&lon=109.2333&appid=5b81f23bdaf17c143746cfa54086b808&units=metric") else { return }
        
        downloadData(url: url) { data in
            
            if let data = data {
                do {
                    let newDatas = try JSONDecoder().decode(WeatherModel.self, from: data)
                    DispatchQueue.main.async {
                        self.listData = newDatas.list
                        self.cityData = newDatas.city
                    }
                } catch {
                    print(error)
                }
            } else {
                print("No data!")
            }
        }
    }
    
    func downloadData(url: URL, completionHandle: @escaping (_ data: Data?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300,
                error == nil else {
                print("Error download data!")
                return
            }
            print("JSON data: \(String(describing: String(data: data, encoding: .utf8)))")
            completionHandle(data)
        }.resume()
    }
}
