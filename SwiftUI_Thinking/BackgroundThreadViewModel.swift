//
//  BackgroundThreadViewModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 02/02/2023.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {

        DispatchQueue.global(qos: .userInteractive).async {
            let newData = self.downloadData()
            print(Thread.current)

            DispatchQueue.main.async {
                self.dataArray = newData
                print(Thread.current)
            }
        }
    }
    
    func downloadData() -> [String] {
        
        var data: [String] = []
        
        for x in 0..<500 {
            data.append(x.description)
        }
        
        return data
    }
}

