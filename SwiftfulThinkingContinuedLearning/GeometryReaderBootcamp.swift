//
//  GeometryReaderBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 24.06.2023.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    
    func getPercentage(geo: GeometryProxy)  -> Double {
        let maxDistance = UIScreen.main.bounds.width/2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX/maxDistance))
    }
    
    var body: some View {
        
        ScrollView (.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                //Angle(degrees: 10),
                                Angle(degrees: getPercentage(geo: geometry)*20),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                    
                }
            }
        })
        
        
        
        //GeometryReader very expensive
//        GeometryReader { geometry in
//            HStack (spacing: 0){
//                Rectangle().fill(Color.red)
//                    .frame(width: geometry.size.width * 0.6666)
//                Rectangle().fill(Color.blue)
//            }
//            .ignoresSafeArea()
//        }
        
        
        
     
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            GeometryReaderBootcamp()
        }
    }
}
