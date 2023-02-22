//
//  Browse.swift
//  Scanner
//
//  Created by Mirza Baig on 03/12/22.
//

import SwiftUI

struct Browse: View {
    @State private var showImagePicker: Bool = false
    @State private var image: UIImage?
    
    
    @State private var searchText = ""
    var body: some View {
        NavigationStack{
            Text("Nothing to Browse")
                .navigationTitle("Browse")
        }
        .searchable(text: $searchText, prompt: "Search in Browse")
    }
}

struct Browse_Previews: PreviewProvider {
    static var previews: some View {
        Browse()
    }
}
