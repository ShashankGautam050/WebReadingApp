//
//  PDFViewWrapper.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 31/01/26.
//

import SwiftUI
import PDFKit

struct PDFViewWrapper: UIViewRepresentable {
    
    let fileURL : URL
    func makeUIView(context: Context) -> PDFView {
        PDFView()
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(url: fileURL)
    }
  
}


