//
//  DocumentDetails.swift
//  Scanner
//
//  Created by Mirza Baig on 04/08/23.
//

import SwiftUI

struct DocumentDetails: View {
    
    @State private var directories:[URL] = []
    
    @Binding var searchText: String
    
    @State private var image: UIImage?
    
    
    #if os(iOS)
    let columns: [GridItem] = [.init(.adaptive(minimum: 100))]
    #elseif os(macOS)
    let columns: [GridItem] = [.init(.adaptive(minimum: 160))]
    #endif
    
    var body: some View {
        VStack{
            LazyVGrid(columns: columns){
                ForEach(directories.filter({searchText.isEmpty ? true : $0.lastPathComponent.localizedStandardContains(searchText)}), id: \.self){ directory in
//                    NavigationLink(destination: {
//                        PDFViewWrapper(url: directory)
//                            .navigationTitle(directory.lastPathComponent)
//                    }, label: {
//                        DocumentIconView(directory:directory)
//                    })
                    DocumentIconView(directory: directory)
                }
            }
            .padding()
            Spacer()
        }
        .onAppear{
            readDirectory()
        }
    }
    func readDirectory() {
        directories = []
        do {
            let pathURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let readDirectory = try FileManager.default.contentsOfDirectory(at: pathURL, includingPropertiesForKeys: nil)
            directories = readDirectory
        }
        catch {
            print(error.localizedDescription)
        }
    }
}



struct DocumentDetails_Previews: PreviewProvider {
    @State static var searchText = ""
    static var previews: some View {
        DocumentDetails(searchText: $searchText)
    }
}
