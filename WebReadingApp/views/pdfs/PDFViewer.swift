//
//  PDFViewer.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 31/01/26.
//

import SwiftUI

struct PDFViewer: View {
    let fileURL : URL
    @Bindable var pdfViewmodel : PDFViewModel
    @State var showAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    @Bindable var webstate : WebViewStateViewModel
    @Bindable var pdf : PDFViewModel
    var body: some View {
       PDFViewWrapper(fileURL: fileURL)
            .toolbar {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                
                ShareLink(item : fileURL)

            }
            .alert("Delete \(fileURL.lastPathComponent)",isPresented: $showAlert) {
                Button("Delete",role: .destructive){
                    pdfViewmodel.delete(fileURL)
                    showAlert = false
                    dismiss()
                }
                
            } message: {
                Text("Are you sure you want to delete this file?")
            }
            .onChange(of: webstate.generatedPDFURL) { oldValue, newValue in
                guard let _ = newValue else { return }
                
                pdf.loadPdfFiles()
            }
            
    }
}

#Preview {
    NavigationStack {
        PDFViewer(fileURL: URL(string: "www.google.com")!,pdfViewmodel: PDFViewModel(), webstate: WebViewStateViewModel(), pdf: PDFViewModel())
    }
  
}
