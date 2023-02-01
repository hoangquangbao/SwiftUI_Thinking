//
//  DownloadingImagesRow.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/12/2022.
//

import SwiftUI

struct DownloadingImagesRow: View {
    
    let data: PhotoModel
    
    var body: some View {
        HStack {
            DownloadImageView(url: data.url, key: "\(data.id)")
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(data.title)
                    .font(.headline)
                
                Text(data.url)
                    .foregroundColor(.gray)
                    .italic()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DownloadingImagesRow_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesRow(data: PhotoModel(
            albumId: 1,
            id: 1,
            title: "title",
            url: "https://via.placeholder.com/600/92c952",
            thumbnailUrl: "https://via.placeholder.com/600/92c952"))
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
