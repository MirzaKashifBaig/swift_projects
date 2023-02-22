//
//  ImportPhotoButton.swift
//  Scanner
//
//  Created by Mirza Baig on 22/02/23.
//

import SwiftUI
import PhotosUI

struct ImportPhotoButton: View{
    @State var selectedItem: [PhotosPickerItem] = []
    @State var data: Data?

    @Binding var open: Bool

    var icon = "camera"
    var color = "Blue"
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, label: {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
        })
        .padding()
        .background(Color(.blue))
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1: 0)
        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
    }
}

