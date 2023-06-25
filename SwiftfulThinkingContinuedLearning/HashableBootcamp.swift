//
//  HasgableBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 25.06.2023.
//

import SwiftUI


struct MyCustomodel : Hashable {
    let title: String
//    let subtitle: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title) // + subtitle)
    } //we can use id we don't need conform to hashable
    
}

struct HasgableBootcamp: View {
    
    //Strings conform to Hashable we can create unique ids for these strings!
//    let data: [String] = [
//    "One", "Two", "Three", "Four", "Five"
//    ]
    
    let data: [MyCustomodel] = [
        MyCustomodel(title: "ONE"),
        MyCustomodel(title: "TWO,"),
        MyCustomodel(title: "THREE,"),
        MyCustomodel(title: "FOUR"),
        MyCustomodel(title: "FIVE"),
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                
//                ForEach(data) {item in
//                    Text(item)
//                        .font(.headline)
//                }
                
                
                
                ForEach(data, id: \.self) {  item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
                .padding(.top, 40)
            }
        }
    }
}

struct HasgableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HasgableBootcamp()
    }
}
