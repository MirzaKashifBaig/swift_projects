//
//  ScanButtonViewModel.swift
//  Scanner
//
//  Created by Mirza Baig on 22/02/23.
//

import Foundation
import SwiftUI


class ScanButtonViewModel: ObservableObject {
    @Published var scanButtonOpen = false
    
    @Published var importFileButton = false
    @Published var showImagePicker = false
    
    @Published var sourceType: UIImagePickerController.SourceType = .camera
}
