//
//  Browse.swift
//  Scanner
//
//  Created by Mirza Baig on 03/12/22.
//

import SwiftUI

struct Browse: View {
    
    @EnvironmentObject private var scanButtonVM: ScanButtonViewModel
    
    
    @State private var createFolderAlert = false
    @State private var renameFolderAlert = false
    
    @State private var image: UIImage?
    
    @State private var folderName = ""
    @State private var renameFoldderName = ""
    
    @State private var directories:[URL] = []
    
    
    @State private var searchText = ""
    var body: some View {
        NavigationStack{
            ZStack{
                List{
                    ForEach(0..<directories.count, id: \.self) { index in
                        NavigationLink(destination: {
                            VStack{
                                Text("Inside File")
                            }
                            .navigationTitle(directories[index].lastPathComponent)
                        }, label: {
                            Text("\(directories[index].lastPathComponent)")
                        })
                        .swipeActions(allowsFullSwipe: true, content: {
                            HStack{
                                Button(action: { deleteDirectory(at: directories[index], index: index)}, label: {
                                    Label("Delete", systemImage: "trash")
                                })
                                .tint(.red)
                                
                                Button(action: {
                                    renameFoldderName = directories[index].lastPathComponent
                                    renameFolderAlert.toggle()
                                }, label: {
                                    Label("Rename", systemImage: "Pencil")
                                })
                                
                                .tint(.gray)
                            }
                        })
                        .alert("Rename", isPresented: $renameFolderAlert) {
                            TextField("Enter Folder Name", text: $renameFoldderName)
                            Button("Cancel", action: {
                                renameFolderAlert.toggle()
                            })
                            Button(action: {renameDirectory(from: directories[index], name: renameFoldderName)}, label: {
                                Text("Rename Folder")
                            })
                        }
                    }
                    Button(action: {createFolderAlert.toggle() }, label: {
                        Label("Create A New Folder", systemImage: "plus.rectangle.on.folder.fill")
                    })
                    .alert("Create New Folder", isPresented: $createFolderAlert) {
                        TextField("Folder Name", text: $folderName)
                        Button("Cancel", action: {
                            createFolderAlert.toggle()
                        })
                        Button(action: {
                            createDirectory()
                            folderName = ""
                        }, label: {
                            Text("Create Folder")
                        })
                    }
                }
                VStack{
                    Spacer()
                    ScanOptionButton()
                    
                }
                
            }
            .navigationTitle("Browse")
        }
        .onAppear{
            readDirectory()
        }
        .sheet(isPresented: $scanButtonVM.showImagePicker, content:{
            CameraPickerView(image: $image, isShown: $scanButtonVM.showImagePicker, sourceType: scanButtonVM.sourceType)
        })
        .searchable(text: $searchText, prompt: "Search in Browse") 
    }
    
    // MARK: Read Directory
    
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
    
    
    // MARK: Create Directory
    func createDirectory() {
        do {
            let pathURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let newFolder = pathURL.appending(path: folderName)
            try FileManager.default.createDirectory(at: newFolder, withIntermediateDirectories: false)
            readDirectory()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    

    // MARK: Delete Directory
    func deleteDirectory(at: URL, index: Int) {
        do{
            try FileManager.default.removeItem(at: at)
            directories.remove(at: index)
            readDirectory()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Rename Directory
    
    func renameDirectory(from: URL, name: String) {
        do {
            let pathURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let newURL = pathURL.appending(path: name)
            try FileManager.default.moveItem(at: from, to: newURL)
            readDirectory()
        }
        catch{
            print(error.localizedDescription)
        }
    }
}


struct Browse_Previews: PreviewProvider {
    static var previews: some View {
        Browse()
            .environmentObject(ScanButtonViewModel())
    }
}
