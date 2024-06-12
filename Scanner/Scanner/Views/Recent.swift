//
//  Recent.swift
//  Scanner
//
//  Created by Mirza Baig on 03/12/22.
//

import SwiftUI

struct Recent: View {
    
    @EnvironmentObject private var scanButtonVM: ScanButtonViewModel
    
    @State private var searchText  = ""
    
    @State private var directories:[URL] = []
    
    @State private var image: UIImage?
    
    #if os(iOS)
    let columns: [GridItem] = [.init(.adaptive(minimum: 100))]
    #elseif os(macOS)
    let columns: [GridItem] = [.init(.adaptive(minimum: 160))]
    #endif
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                List{
                    DocumentDetails(searchText: $searchText)
                }
                .scrollContentBackground(.hidden)
                
                VStack{
                    Spacer()
                    ScanOptionButton()
                }
            }
            .navigationTitle("Recent")
            .toolbar{
                Button(action: {}, label: {
                    Image(systemName: "gear")
                })
            }
        }
        .sheet(isPresented: $scanButtonVM.showImagePicker, content:{
            CameraPickerView(image: $image, isShown: $scanButtonVM.showImagePicker, sourceType: scanButtonVM.sourceType)
        })
        .searchable(text: $searchText, prompt: "Search In Recent")
        
    }
}


struct Recent_Previews: PreviewProvider {
    static var previews: some View {
        Recent()
            .environmentObject(ScanButtonViewModel())
    }
}

