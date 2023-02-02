//
//  WeatherView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/02/2023.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var vm = WeatherViewModel()
    
    var body: some View {
        ScrollView {

            ForEach(vm.listData, id: \.dt) { data in
                Text("Temp: \(data.main.temp)")
            }
            Text(vm.cityData?.name ?? "HUE")
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
