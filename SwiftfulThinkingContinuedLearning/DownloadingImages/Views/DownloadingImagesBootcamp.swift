//
//  DownloadingImagesBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 27.06.2023.
//

import SwiftUI


// Codable
// background threads
// weak self
// Combine
// Publishers and Subscribers
// FileManager
// NSCache

struct DownloadingImagesBootcamp: View {
    
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                    
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}
struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}
