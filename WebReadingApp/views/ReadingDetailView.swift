//
//  ReadingDetailView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 28/01/26.
//

import SwiftUI

struct ReadingDetailView: View {
    
    let readingItem : ReadingItem
    @State private var webViewState = WebViewStateViewModel()
    @Bindable  var readingDataViewModel :ReadingDataViewModel
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
             WebNavigationBar(webViewState: webViewState)
                .padding()
           
            }
        .onChange(of: readingItem) { oldValue, newValue in
            guard let url = newValue.url else { return }
//            webViewState.update(url)
            webViewState.userRequestedToOpen((url))
        }
        .onAppear{
            guard let url = readingItem.url else { return }
//            webViewState.update(url)
            webViewState.userRequestedToOpen((url))
        }
        .toolbar {
            
            if let new = webViewState.currentURL,webViewState.url != new {
                Button("Create a new Reading") {
                    readingDataViewModel.addNewReadingItem(title: webViewState.currentTitle ?? "title", url: new)
                }
            }
        }
    }
}

#Preview {
    ReadingDetailView(readingItem: ReadingItem.example, readingDataViewModel: ReadingDataViewModel())
}
