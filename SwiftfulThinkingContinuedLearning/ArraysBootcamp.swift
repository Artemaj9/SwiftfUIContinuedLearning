//
//  ArraysBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 25.06.2023.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let point: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray : [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    func updateFilteredArray() {
        
        //sort
        /*
//       filteredArray = dataArray.sorted { (user1, user2) -> Bool in
//            return user1.point > user2.point
//        }
        
//        filteredArray = dataArray.sorted(by: {$0.point > $1.point})
         */
        
        
        //filter
        /*
        filteredArray = dataArray.filter({ (user) -> Bool in
            return user.point > 7
//            user.name.contains("i")
            filteredArray = dataArray.filter({$0.isVerified})
           
        })
         */
        
        //map
     /*
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name
//        })
        
//        mappedArray = dataArray.map({ $0.name})
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name ?? "ERROR"
//        })
        mappedArray = dataArray.compactMap({(user) -> String? in
            return user.name
        })
        mappedArray = dataArray.compactMap({$0.name})
      */
        
//        let sort = dataArray.sorted(by: { $0.point > $1.point })
//        let filter = dataArray.filter ({ $0.isVerified })
//        let map = dataArray.compactMap ({ $0.name })
//
        mappedArray = dataArray.sorted(by: {$0.point > $1.point})
           .filter({ $0.isVerified })
                .compactMap({ $0.name})
            
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nick", point: 1, isVerified: true)
        let user2 = UserModel(name: "Den", point: 5, isVerified: false)
        let user3 = UserModel(name: nil, point: 7, isVerified: true)
        let user4 = UserModel(name: "Artem", point: 25, isVerified: true)
        let user5 = UserModel(name: "Bob", point: 5, isVerified: true)
        let user6 = UserModel(name: "John", point: 9, isVerified: true)
        let user7 = UserModel(name: nil, point: 5, isVerified: false)
        let user8 = UserModel(name: "Dmitry", point: 2, isVerified: true)
        let user9 = UserModel(name: "Avdei", point: 4, isVerified: false)
        let user10 = UserModel(name: "Gidrid", point: 11, isVerified: true)
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
            
    }
}
    
struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.point)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "star.fill")
//                                    .foregroundColor(.yellow)
//                            }
//
//                        }
//
//                    }
//
//                    .foregroundColor(.white)
//                    .padding(10)
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal, 20)
//                }
                
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
