//
//  ScanOptionButton.swift
//  Scanner
//
//  Created by Mirza Baig on 19/02/23.
//

import SwiftUI
import PhotosUI

struct ScanOptionButton: View {
    @EnvironmentObject private var scanButtonVM: ScanButtonViewModel
    
    
    var body: some View {
        ZStack{
            Button(action: {
                withAnimation {
                    self.scanButtonVM.scanButtonOpen.toggle()
                }
                
            }) {
                Image(systemName: "plus")
                    .rotationEffect(.degrees(scanButtonVM.scanButtonOpen ? 45 : 0))
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0), value: self.scanButtonVM.scanButtonOpen)
            }
            .padding(12)
            .background(Color(.systemBlue))
            .mask(Circle())
            .zIndex(10)
            
            ImportFileButton(open: $scanButtonVM.scanButtonOpen, icon: "folder.fill", offsetX: 0, offsetY: -115, delay: 0.2)
            CameraButton(open: $scanButtonVM.scanButtonOpen, icon: "camera", offsetX: 75, offsetY: -60, delay: 0.2)
            ImportPhotoButton(open: $scanButtonVM.scanButtonOpen, icon: "photo.on.rectangle.angled", offsetX: -75, offsetY: -60, delay: 0.2)
            
        }
    }
}

struct ScanOptionButton_Previews: PreviewProvider {

    static var previews: some View {
        ScanOptionButton()
            .environmentObject(ScanButtonViewModel())
    }
}

struct ImportFileButton: View{
    
    @EnvironmentObject var importFileVM: ScanButtonViewModel
    
    @Binding var open: Bool
    
    
    var icon = "folder"
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0
    
    var body: some View {
        Button(action: {
            importFileVM.importFileButton.toggle()
        }, label: {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
        })
        .padding()
        .background(Color(.systemBlue))
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1: 0)
        .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0), value: importFileVM.importFileButton)
        .fileImporter(isPresented: $importFileVM.importFileButton, allowedContentTypes: [.pdf,.png,.jpeg], allowsMultipleSelection: false){result in
            do {
                print(result)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
}


struct CameraButton: View{
    
    @EnvironmentObject var cameraVM: ScanButtonViewModel
    
    @Binding var open: Bool

    
    var icon = "camera"
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
        .background(Color(.systemBlue))
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1: 0)
        .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)), value: cameraVM.showImagePicker)
    }
}


