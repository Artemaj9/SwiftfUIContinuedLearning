//
//  SubscriberBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 26.06.2023.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
    }
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)  //delay before running code
            .map { (text) -> Bool in
                if text.count >= 3 {
                    return true
                }
                return false
            }
          //  .assign(to: \.textIsValid, on: self) // no way to make self weak.Reccomended use sink whenever you can
            .sink(receiveValue: {[weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return } //we make self weak
                self.count += 1
//                if self.count >= 10 {
//                    for item in self.cancellables {
//                            item.cancel()
                }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text(vm.textIsValid.description)
            
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .fontWeight(.bold)
                .background(Color.gray)
                .cornerRadius(10)
                .overlay(
                         ZStack {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .opacity(vm.textFieldText.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0)
                    
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .opacity(vm.textIsValid ? 1.0 : 0)
                }
                .font(.title)
                .padding(.trailing)
                         
                , alignment: .trailing)
                         
        }
    }
    
    }


struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}