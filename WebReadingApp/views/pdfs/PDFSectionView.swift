//
//  PDFSectionView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 31/01/26.
//

import SwiftUI

struct PDFSectionView: View {
    
    @Bindable var pdfFileViewModel : PDFViewModel
    
    @State var isExpanded : Bool = false
    var body: some View {
        Section("Saved Pdf",isExpanded: $isExpanded) {
            ForEach(pdfFileViewModel.pdfFiles,id: \.self) { file in
                Text(file.lastPathComponent)
                    .lineLimit(1)
                    .tag(ContentView.NavigationSelcetion.pdf(url: file))
            }
        }
    }
}
#Preview {
    List{
        PDFSectionView(pdfFileViewModel: PDFViewModel())
    }
    
}
