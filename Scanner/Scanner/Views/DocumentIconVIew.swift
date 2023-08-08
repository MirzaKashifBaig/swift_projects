//
//  DocumentIconVIew.swift
//  Scanner
//
//  Created by Mirza Baig on 07/08/23.
//

import SwiftUI

struct DocumentIconVIew: View {
    
    @State var directory:URL
    
    
    var body: some View {
        VStack{
            //MARK: Cover page Of Document
            Image(systemName: "car")
                .font(.system(size: 80))
                
            
            //MARK: Name Of Document
            Text(directory.lastPathComponent)
                .font(.title2)
                .lineLimit(1)
                .foregroundColor(Color("primaryText"))
            
            //MARK: Time Detail Of Document
            Text("\(directory.createdDate.formatted())")
                .foregroundColor(Color("primaryText"))
                .multilineTextAlignment(.leading)
            
            //MARK: Size Of Document
            
            Text("\(directory.size, specifier: "%.1f")")
                .lineLimit(1)
                .foregroundColor(Color("primaryText"))
                .multilineTextAlignment(.leading)
        }
    }
    
//    func calculateDocumentSize() -> String {
//        let documentSize = directory.size
//        if documentSize >= 
//    }
}

//struct DocumentIconVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentIconVIew()
//    }
//}
