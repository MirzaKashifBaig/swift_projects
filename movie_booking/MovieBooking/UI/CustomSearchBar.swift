//
//  CustomSearchBar.swift
//  MovieBooking
//
//  Created by Mirza Baig on 26/09/22.
//

import SwiftUI

struct CustomSearchBar: View {
    @State var searchText = ""
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $searchText)
            Image(systemName: "mic.fill")
        }
        .padding(EdgeInsets(top: 7, leading: 8, bottom: 7, trailing: 8))
        .font(.headline)
        .background(.ultraThinMaterial)
        .foregroundColor(.white.opacity(0.06))
        .cornerRadius(10)
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBar()
    }
}
