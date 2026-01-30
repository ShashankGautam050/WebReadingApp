//
//  WebNavigationBar.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 30/01/26.
//

import SwiftUI

struct WebNavigationBar: View {
    @Bindable var webViewState : WebViewStateViewModel
    @State private var currentURL: String = ""
    var body: some View {
        HStack {
            Button {
                webViewState.goBack()
            } label: {
                Image(systemName: "chevron.backward")
            }
            .disabled(!webViewState.canGoBack)
            Button {
                webViewState.goForward()
            } label: {
                Image(systemName: "chevron.forward")
            }
            .disabled(!webViewState.canGoForward)
            
            TextField("current URL", text: $currentURL)
                .truncationMode(.middle)
                .textFieldStyle(.roundedBorder)
        }
        .onAppear{
            currentURL = webViewState.url?.absoluteString ?? ""
        }
        .onChange(of: webViewState.currentURL) { oldValue, newValue in
            currentURL = newValue?.absoluteString ?? ""
        }
    }
}

#Preview {
    WebNavigationBar(webViewState: WebViewStateViewModel())
}
