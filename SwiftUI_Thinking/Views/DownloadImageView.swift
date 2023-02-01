//
//  DownloadImageView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 26/12/2022.
//

import SwiftUI

struct DownloadImageView: View {
    
    @StateObject var loaderVm: ImageLoadingViewModel
    
    init(url: String, key: String) {
        _loaderVm = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if loaderVm.isLoading {
                ProgressView()
            } else if let image = loaderVm.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

struct DownloadImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
