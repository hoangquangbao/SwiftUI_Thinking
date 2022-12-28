//
//  DownloadingImagesBootcampView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/12/2022.
//

import SwiftUI

struct DownloadingImagesBootcampView: View {
    
    @StateObject var vm = DownloadImageViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { data in
                    DownloadingImagesRow(data: data)
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Downloading data!!")
        }
    }
}

struct DownloadingImagesBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcampView()
    }
}
