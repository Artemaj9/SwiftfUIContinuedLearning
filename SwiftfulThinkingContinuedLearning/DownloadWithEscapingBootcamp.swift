//
//  DownloadWithEscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 26.06.2023.
//

import SwiftUI

// Cool site to set up the Model https://app.quicktype.io/
struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard  let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        downladData(fromURL: url) { returneData in
            if let data = returneData {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else {return}
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
                
            } else {
                print("No data returned")
            }
        }
    }
    
    func downladData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> Void) {
        //Background thread
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //All checks with 1 guard statement:
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloadind data.")
                completionHandler(nil)
                return
            }
            
            //            guard let data = data else {
            //                print("No data.")
            //                return
            //            }
            //
            //            guard error == nil else {
            //                print("Error: \(String(describing: error))")
            //                return
            //            }
            //            guard let response = response as? HTTPURLResponse else {
            //                print("Invalid response")
            //                return
            //            }
            //
            //            guard response.statusCode >= 200 && response.statusCode < 300 else {
            //                print("Status code should be 2xx, but is \(response.statusCode)")
            //                return
            //            }
            //
            //            print("SUCESSFULLY DOWNLOADED DATA!")
            //            print(data)
            
            completionHandler(data)
            //        guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else {return}
            //        DispatchQueue.main.async { [weak self] in
            //            self?.posts.append(newPost)
            //        }
            
            
        }.resume()
    }
}
struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) {post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                
            }
        }
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
