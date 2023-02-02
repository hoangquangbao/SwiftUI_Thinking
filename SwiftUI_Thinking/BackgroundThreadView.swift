//
//  BackgroundThreadView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 02/02/2023.
//

import SwiftUI

struct BackgroundThreadView: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Download")
                    .onTapGesture {
                        vm.fetchData()
                    }
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                }
            }
        }
    }
}

struct BackgroundThreadView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadView()
    }
}
