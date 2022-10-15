//
//  OffsetPractice.swift
//  MovieBooking
//
//  Created by Mirza Baig on 23/09/22.
//

import SwiftUI

struct OffsetPractice: View {
    
    @State private var widthOffset:CGFloat = 0
    @State private var heightOffset:CGFloat = 0
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        VStack{
            Color.red
                .frame(width: 200, height: 200)
                .offset(x: widthOffset, y: heightOffset)
                .gesture(
                    
                    DragGesture()
                        .onChanged({value in
                            withAnimation(.easeIn){
                                widthOffset = value.translation.width
                                heightOffset = value.translation.height
                                
                            }
                        })
                )
        }
        .onAppear{
            print(width,height)
        }
    }
}

struct OffsetPractice_Previews: PreviewProvider {
    static var previews: some View {
        OffsetPractice()
    }
}
