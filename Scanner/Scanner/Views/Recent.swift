//
//  Recent.swift
//  Scanner
//
//  Created by Mirza Baig on 03/12/22.
//

import SwiftUI

struct Recent: View {
    
    @State private var searchText  = ""
    
    var body: some View {
        NavigationStack{
            Text("There is nothing in recent list")
                .navigationTitle("Recent")
        }
        .searchable(text: $searchText)
    }
}

struct Recent_Previews: PreviewProvider {
    static var previews: some View {
        Recent()
    }
}
