//
//  PDFView.swift
//  Scanner
//
//  Created by Mirza Baig on 25/03/23.
//

import SwiftUI
import PDFKit

struct PDFViewWrapper: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
}
