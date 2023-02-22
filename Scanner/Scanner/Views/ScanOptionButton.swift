//
//  ScanOptionButton.swift
//  Scanner
//
//  Created by Mirza Baig on 19/02/23.
//

import SwiftUI
import PhotosUI

struct ScanOptionButton: View {
    
    @State var open = false
    
    var body: some View {
        ZStack{
            Button(action: {self.open.toggle()}) {
                Image(systemName: "plus")
                    .rotationEffect(.degrees(open ? 45 : 0))
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
            }
            .padding(12)
            .background(Color(.blue))
            .mask(Circle())
            .zIndex(10)
            
            CameraButton(open: $open, icon: "camera", color: "Blue",offsetX: 60, offsetY: -60)
            ImportPhotoButton(open: $open, icon: "photo.on.rectangle.angled", color: "Blue", offsetX: -60, offsetY: -60, delay: 0.2)
        }
    }
}

struct ScanOptionButton_Previews: PreviewProvider {

    static var previews: some View {
        ScanOptionButton()
    }
}


struct CameraButton: View{
    
    @EnvironmentObject var cameraVM: ScanButtonViewModel
    
    @Binding var open: Bool

    
    var icon = "camera"
    var color = "Blue"
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0
    
    var body: some View {
        Button(action: {
            cameraVM.showImagePicker.toggle()
            cameraVM.sourceType = .camera
        }) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
        }
        .padding()
        .background(Color(.blue))
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1: 0)
        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
    }
}


