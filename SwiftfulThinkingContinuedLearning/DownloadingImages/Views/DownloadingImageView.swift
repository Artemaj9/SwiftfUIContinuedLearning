//
//  DownloadingImageView.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 27.06.2023.
//

import SwiftUI

struct DownloadingImageView: View {

    @StateObject var loader: ImageLoadingViewModel
    
    init(url: String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url))
    }

    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

struct DownloadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageView(url: "https://via.placeholder.com/600/92c952")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
