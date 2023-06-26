//
//  WeakSelfBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 26.06.2023.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
            }
        .overlay(
        Text("\(count ?? 0)")
            .font(.largeTitle)
            .padding()
            .background(Color.green.cornerRadius(10)),
        alignment: .topTrailing
        )
        }
    
}
struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}


class WeakSelfSecondScreenViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "Count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "Count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 500) {[weak self] in
            self?.data = "NEW DATA!!!"
            //we don't absolutely need to stay this class alive!
        }
       
    }
}



struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}
