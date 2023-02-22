//
//  ContentView.swift
//  Scanner
//
//  Created by Mirza Baig on 03/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var scanButtonVM = ScanButtonViewModel()
    @State private var image: UIImage?

    var body: some View {
        ZStack{
            TabView{
                Recent()
                    .tabItem{
                        Label("Recent", systemImage: "clock.fill")
                    }
                Browse()
                    .tabItem{
                        Label("Browse", systemImage: "folder.fill")
                    }
            }
            VStack{
                Spacer()
                HStack{
                    ScanOptionButton()
                        .environmentObject(scanButtonVM)
                }
            }
            .sheet(isPresented: $scanButtonVM.showImagePicker, content:{
                CameraPickerView(image: $image, isShown: $scanButtonVM.showImagePicker, sourceType: scanButtonVM.sourceType)
            })
            .padding(.bottom,50)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
