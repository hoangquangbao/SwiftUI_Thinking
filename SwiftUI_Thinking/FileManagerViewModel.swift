//
//  FileManagerViewModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 02/02/2023.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() {}
    
    func saveImage(image: UIImage, name: String) {
        
        guard let data = image.jpegData(compressionQuality: 0.5),
              let path = getPathForImage(name: name) else {
            print("Error getting data!")
            return
        }
        
        do {
            try data.write(to: path)
            print("Success save!")
        } catch {
            print("Save error!")
            print(error)
        }
        
        //REFER
        /* This code links is an array then need add .first */
        //        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        /* This code line is string*/
        //        let directory = FileManager.default.temporaryDirectory
    }
    
    func getImage(name: String) -> UIImage? {
        //func getPathForImage(name: name) return an url then we'll add .path() convert to STRING
        guard let path = getPathForImage(name: name)?.path(),
              FileManager.default.fileExists(atPath: path) else {
            print("Error getting path!")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let directory = FileManager
                .default
                //We'll special the directory to save
                .urls(for: .cachesDirectory, in: .userDomainMask)
                //Result of this code line is an array then we'll add .first (Refer in REFER)
                .first?
                //comlect the path
                .appendingPathComponent("\(name)", conformingTo: .jpeg)
        else {
            print("Error create path!")
            return nil
        }
        
        return directory
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName: String = "img_chao"
    let manager = LocalFileManager.instance
    
    init() {
//        getImageFromAssetFolder()
        image = manager.getImage(name: imageName)
    }
    
    func getImageFromAssetFolder() {
        image = UIImage(named: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        manager.saveImage(image: image, name: imageName)
    }
}
