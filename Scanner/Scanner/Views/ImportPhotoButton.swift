//
//  ImportPhotoButton.swift
//  Scanner
//
//  Created by Mirza Baig on 22/02/23.
//

import SwiftUI
import PhotosUI
import PDFKit

struct ImportPhotoButton: View{
    @State var selectedItem: [PhotosPickerItem] = []
    @State var data: [Data] = []

    @Binding var open: Bool

    var icon = "camera"
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, label: {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
        })
        .padding()
        .background(Color(.systemBlue))
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1: 0)
        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)), value: open)
        .onChange(of: selectedItem){ newItems in
            Task{
                let pdfDocument = PDFDocument()
                selectedItem = []
                for (index,item) in newItems.enumerated() {
                    if let newData = try? await item.loadTransferable(type: Data.self){
                        let uiImage = UIImage(data: newData)
                        let pdfImage = PDFPage(image: uiImage!)
                        pdfDocument.insert(pdfImage!, at: index)
                        data.append(newData)
                    }
                }
                let pdfData = pdfDocument.dataRepresentation()
                
                let docDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                print(docDirectory)
                let docURL = docDirectory.appendingPathComponent("Scanned-Doc \(Date().formatted(.dateTime.year(.twoDigits).month().day().hour().minute().second()))", conformingTo: .pdf)
                do{
                    try pdfData?.write(to: docURL)
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

