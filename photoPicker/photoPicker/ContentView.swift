

import SwiftUI
import PhotosUI
import PDFKit

struct ContentView: View {
    
    @State private var selectedImage:[PhotosPickerItem] = []
    @State private var selectedImageData: [Data] = []
    
    var body: some View {
        NavigationStack {
            VStack{
                if selectedImageData.count > 0{
                    // Show Image
                    ScrollView{
                        LazyVGrid(columns: [.init(.adaptive(minimum: 200)), .init(.adaptive(minimum: 200))]){
                            ForEach(selectedImageData, id: \.self){ dataItem in
                                #if os(macOS)
                                if let dataItem = dataItem, let nsImage = NSImage(data: dataItem){
                                    Image(nsImage: nsImage).resizable().frame(width: 180, height: 150).aspectRatio(contentMode: .fill).cornerRadius(10)
                                }
                                #elseif os(iOS)
                                if let dataItem = dataItem, let uiImage = UIImage(data: dataItem){
                                    Image(uiImage: uiImage).resizable().frame(width: 180, height: 150).aspectRatio(contentMode: .fill).cornerRadius(10)
                                }
                                #endif
                                
                            }
                        }
                        .padding()
                    }
                }
                else{
                    Spacer()
                    Text("Please select image by tapping on photo icon on toolbar").foregroundColor(.gray).font(.system(size: 25)).bold().multilineTextAlignment(.center)
                }
                Spacer()
                Text("\(selectedImageData.count) photos")
            }
            .navigationTitle("Photo Album")
            .toolbar{
                PhotosPicker(selection: $selectedImage,maxSelectionCount: 50 ,matching: .images, label: {
                    Image(systemName: "photo.fill").tint(.mint)
                })
                .onChange(of: selectedImage){newItem in
                    Task{
                        selectedImage = []
                        print("Application directory: \(NSHomeDirectory ())")
                        let pdfDocument = PDFDocument()
                        let totalCount = newItem.count - 1
                        var pageCount = 0
                        for item in newItem {
                            if let data = try? await item.loadTransferable(type: Data.self){
//                                selectedImageData.append(data)
                                let image = UIImage(data: data)
//
                                let pdfPage = PDFPage(image: image!)
                                
                                pdfDocument.insert(pdfPage!, at: pageCount)
                                
                                
                                if pageCount <= totalCount{
                                    pageCount += 1
                                }
                                
                            }
                        }
                        
                        let data = pdfDocument.dataRepresentation()
                        
                        let urls = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

                        let url = URL(string: NSTemporaryDirectory())!.appendingPathExtension(".pdf")
                        
                        do{
                            try data!.write(to: url)
                            
1                        }catch{
                             print(error)
                        }
                        
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
