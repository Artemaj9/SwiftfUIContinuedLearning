//
//  FileManagerBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 27.06.2023.
//

import SwiftUI


class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
        init() {
            createFolderIfNeeded()
        }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path else {
            return
        }
        if  !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Success creating folder.")
            } catch let error {
                print("Error creating folder \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder.")
        } catch let error {
            print("Error deleting folder \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard
            let data = image.pngData(),
            let path = getPathforImage(name: name) else {
            return ("Error getting data.")
        }
        
        //        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     //   let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
      //  let path2 = directory2?.appendingPathComponent("\(name).png")
        
       /* guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).png") else {
            print("Error getting path.")
            return
        }
        */
        do {
            try data.write(to: path)
            print(path)
           return "Success saving!"
        } catch let error {
            return "Error saving. \(error)"
        }
    }
    
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathforImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
        return UIImage(contentsOfFile: path)
        
    }
        
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathforImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            return "Error getting path."
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Sucessfully deleted."
        } catch let error {
            return "Error deleting image. \(error)"
        }
        
    }
    
    func getPathforImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).png") else {
            print("Error getting path.")
            return nil
        }
        return path
    }
        
        
//        print(directory2)
//        print(path)
//        let directory3 = FileManager.default.temporaryDirectory
        
        
        //print(directory)
     //   print(directory2)
        //print(directory3)
       // data.write(to: <#T##URL#>)
    }

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName: String = "zvezdopad"
    let manager = LocalFileManager.instance
    @Published var infoMessage: String = ""
    
    init() {
        getImageFromAssetsFolder()
        saveImage()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}


struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
