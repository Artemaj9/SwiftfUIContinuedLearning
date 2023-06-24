//
//  MaskBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 24.06.2023.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 4
    
    var body: some View {
        ZStack{
           starsView
                .overlay(
                  overlayView
                    .mask(starsView)
                )
        }
        
    }
    
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                   // .foregroundColor(.yellow)
                    .fill(LinearGradient(colors: [Color.yellow, Color.orange, Color.red], startPoint: .leading, endPoint: .trailing))
                    .frame(width: geometry.size.width * CGFloat(rating)/5)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) {index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
        
    }
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}
