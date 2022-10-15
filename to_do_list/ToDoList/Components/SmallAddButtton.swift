//
//  SmallAddButtton.swift
//  ToDoList
//
//  Created by Mirza Baig on 01/10/22.
//

import SwiftUI

struct SmallAddButtton: View {
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 50)
                .foregroundColor(Color(hue: 0.304, saturation: 0.897, brightness: 0.384))
            
            Text("+")
                .font(.title3)
                .foregroundColor(.white)
                .fontWeight(.heavy)
        }
        .frame(height: 50)
    }
}

struct SmallAddButtton_Previews: PreviewProvider {
    static var previews: some View {
        SmallAddButtton()
    }
}
