//
//  ContentView.swift
//  Scanner
//
//  Created by Mirza Baig on 03/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @StateObject private var scanButtonVM = ScanButtonViewModel()
    
    var body: some View {
        Group{
            if horizontalSizeClass == .compact {
                TabView{
                    Recent()
                        .tabItem{
                            Label("Recent", systemImage: "clock.fill")
                        }
                    Browse()
                        .tabItem{
                            Label("Browse", systemImage: "folder.fill")
                        }
                }
            }
            else{
                NavigationSplitView{
                    List{
                        NavigationLink(destination: {
                            Recent()
                        }, label: {
                            Label("Recent", systemImage: "clock.fill")
                        })
                        NavigationLink(destination: {
                            Browse()
                        }, label: {
                            Label("Browse", systemImage: "folder.fill")
                        })
                    }
                    .navigationTitle("Scanner")

                } detail: {
                    Browse()
                }
            }
        }
            .environmentObject(scanButtonVM)
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
            .environmentObject(ScanButtonViewModel())
    }
}



extension URL {
    var createdDate: Date {
        let _ = self.startAccessingSecurityScopedResource()
        let attributes = try! FileManager.default.attributesOfItem(atPath: self.path)
        let creationDate = attributes[.creationDate] as? Date ?? Date()
        defer {
            self.stopAccessingSecurityScopedResource()
        }
        return creationDate
    }
    var modifiedDate: Date {
        let _ = self.startAccessingSecurityScopedResource()
        let attributes = try! FileManager.default.attributesOfItem(atPath: self.path)
        let modificationDate = attributes[.modificationDate] as? Date ?? Date()
        defer {
            self.stopAccessingSecurityScopedResource()
        }
        return modificationDate
    }
    var size: Double {
        let _ = self.startAccessingSecurityScopedResource()
        let attributes = try! FileManager.default.attributesOfItem(atPath: self.path)
        let size = attributes[.size] as? Double ?? 0
        defer {
            self.stopAccessingSecurityScopedResource()
        }
        return size
    }
}

