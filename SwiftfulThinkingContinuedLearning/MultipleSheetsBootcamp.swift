//
//  MultipleSheetsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 24.06.2023.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}
// Ways to solve the problem with sheets
// 1 - use a binding
// 2 - use multiple .sheets
// 3 - use $item approach


struct MultipleSheetsBootcamp: View {
    
    @State var selectedModel: RandomModel? = nil
//    @State var showSheet: Bool = false
//    @State var showSheet2: Bool = false
//    @State var selectedIndex: Int = 0
    
    var body: some View {
        ScrollView {
        VStack(spacing: 20) {
            
                
                ForEach(0..<50) { index in
                
                Button("Button \(index)") {
    //                selectedIndex = 1
                    selectedModel = RandomModel(title: "\(index)")
    //                showSheet.toggle()
                }
    //            .sheet(isPresented: $showSheet, content: {
    //                NextScreen(selectedModel: RandomModel(title: "ONE"))
    //            })
    //            Button("Button 2") {
    ////                selectedIndex = 2
    //                selectedModel = RandomModel(title: "TWO")
    //                showSheet2.toggle()
                }
    //            .sheet(isPresented: $showSheet2, content: {
    //                NextScreen(selectedModel: RandomModel(title: "TWO"))
    //            })
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
            }
            
//        .sheet(isPresented: $showSheet, content: {
//            NextScreen(selectedModel: selectedModel)
//          //  NextScreen(selectedModel: selectedModel)
//            //Still not working!!! Not logic into sheet if possible!
////            if selectedIndex == 1 {
////                NextScreen(selectedModel: RandomModel(title: "ONE"))
////            } else if  selectedIndex == 2 {
////                    NextScreen(selectedModel: RandomModel(title: "TWO"))
////            } else {
////                NextScreen(selectedModel: RandomModel(title: "STARTING TITLE"))
////            }
//        })
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}


struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
