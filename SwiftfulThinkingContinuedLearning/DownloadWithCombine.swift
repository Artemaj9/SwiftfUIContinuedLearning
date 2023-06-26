//
//  DownloadWithCombine.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 26.06.2023.
//

import SwiftUI
import Combine
// Cool site to set up the Model https://app.quicktype.io/
struct PostModel1: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts : [PostModel1] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    func getPosts() {
        
        guard  let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        // Combine discussion
        /*
         // 1. Sign up fo monthly subscription for package to be delivered
         // 2. the company would make the package behind the scene
         // 3. recieve the package at your front door
         // 4. make sure the box isn't danaged
         // 5. open and make shure the item is correct
         // 6. use the item!
         // 7. cancellable at any time!
         
         
         // 1. create the publisher
         // 2. subscribe publisher on background thread (done by default in URL Session)
         // 3. receive on main thread
         // 4. tryMap (check that the data is good)
         // 5. decode (decode data into PostModels)
         // 6.sink (put the item into our app
         // 7. store (cancel subscription if neded)
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
        // .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel1].self, decoder: JSONDecoder())
            .replaceError(with: []) // trick to replace error
            .sink(receiveValue: {[weak self] (returnedPosts) in
                self?.posts = returnedPosts
            })
//            .sink { (completion) in
//                switch completion {
//                case .finished:
//                    print("finished")
//                case .failure(let error):
//                    print("There was an error \(error)")
//                }
//                print("COMPLETION: \(completion)")
//            } receiveValue: { [weak self] (returnedPosts) in
//                self?.posts = returnedPosts
//            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) {post in
                VStack(alignment: .leading) {
                    VStack {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
