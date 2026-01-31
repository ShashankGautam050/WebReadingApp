//
//  ReadingDetailView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 28/01/26.
//

import SwiftUI

struct ReadingDetailView: View {
    
    let readingItem : ReadingItem
    @Bindable var webViewState = WebViewStateViewModel()
    @Bindable  var readingDataViewModel :ReadingDataViewModel
    @Bindable var pdf : PDFViewModel
    var body: some View {
        VStack {
            ZStack {
                WebView(webViewState: webViewState)
                
                if webViewState.isLoading {
                    ProgressView()
                        .controlSize(.large)
                        .tint(.red)
                }
            }
            
            if let url = webViewState.generatedPDFURL {
                SuccessSavedFileView(url: url)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                            
                            withAnimation(.bouncy(duration: 2)){
                                webViewState.generatedPDFURL = nil
                            }
                           
                        }
                    }
            }
             WebNavigationBar(webViewState: webViewState)
                .padding()
           
            }
        .onChange(of: readingItem) { oldValue, newValue in
            guard let url = newValue.url else { return }
//            webViewState.update(url)
            webViewState.userRequestedToOpen((url))
        }
        .onChange(of: webViewState.generatedPDFURL) { oldValue, newValue in
            guard let _ = newValue else { return }
            
            pdf.loadPdfFiles()
        }
        .onAppear{
            guard let url = readingItem.url else { return }
//            webViewState.update(url)
            webViewState.userRequestedToOpen((url))
        }
        .toolbar {
            
            
            Menu("More", systemImage: "ellipsis.circle") {
                if let new = webViewState.currentURL,webViewState.url != new {
                    Button("Create a new Reading") {
                        readingDataViewModel.addNewReadingItem(title: webViewState.currentTitle ?? "title", url: new)
                    }
                }
                Button {
                    webViewState.createPDF()
                } label: {
                    Text("Save as a PDF")
                }
            }
          

        }
    }
}

#Preview {
    NavigationStack {
        ReadingDetailView(readingItem: ReadingItem.example, readingDataViewModel: ReadingDataViewModel(), pdf: PDFViewModel())
    }
 
}
