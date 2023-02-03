//
//  FileManagerView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 02/02/2023.
//

import SwiftUI

struct FileManagerView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Button {
                    vm.saveImage()
                } label: {
                    Text("Save to FM")
                        .fontWeight(.bold)
                        .font(.system(size: 15))
                }

                Spacer()
            }
        }
    }
}

struct FileManagerView_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerView()
    }
}
