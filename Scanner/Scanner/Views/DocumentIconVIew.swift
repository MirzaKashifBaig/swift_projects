//
//  DocumentIconView.swift
//  Scanner
//
//  Created by Mirza Baig on 07/08/23.
//

import SwiftUI

struct DocumentIconView: View {
    
    @State var directory:URL
    
    
    var body: some View {
        VStack{
            //MARK: Cover page Of Document
            Image(systemName: "car")
                .font(.system(size: 80))
                
            
            //MARK: Name Of Document
            Text(directory.lastPathComponent)
                .font(.title3)
                .lineLimit(1)
                .foregroundColor(Color("primaryText"))
            
            //MARK: Time Detail Of Document
            Text("\(directory.createdDate.displayFormat)")
                .foregroundColor(Color("primaryText"))
                .multilineTextAlignment(.leading)
                .font(.caption)
          
            //MARK: Size Of Document
            
            Text(getReadableUnit(bytes: directory.size))
                .lineLimit(1)
                .foregroundColor(Color("primaryText"))
                .multilineTextAlignment(.leading)
                .font(.caption)
        }
    }
    
    func getReadableUnit(bytes: Double) -> String {
        
        var kilobytes:Double {
            return Double(bytes) / 1_024
          }
          
        var megabytes:Double {
            return kilobytes / 1_024
          }
          
        var gigabytes: Double {
            return megabytes / 1_024
          }
        
        switch bytes {
        case 0..<1_024:
          return "\(bytes) bytes"
        case 1_024..<(1_024 * 1_024):
          return "\(String(format: "%.2f", kilobytes)) kb"
        case 1_024..<(1_024 * 1_024 * 1_024):
          return "\(String(format: "%.2f", megabytes)) mb"
        case 1_024..<(1_024 * 1_024 * 1_024 * 1_024):
          return "\(String(format: "%.2f", gigabytes)) gb"
        default:
          return "\(bytes) bytes"
        }
      }

}


extension Date {
    var displayFormat: String {
        self.formatted(
            .dateTime
                .year()
                .month(.twoDigits)
                .day(.twoDigits)
        
        )
    }
}

//struct DocumentIconVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentIconVIew()
//    }
//}
