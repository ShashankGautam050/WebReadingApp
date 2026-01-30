//
//  WebView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 30/01/26.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    @Bindable var webViewState : WebViewStateViewModel
    func makeCoordinator() -> Coordinator {
        Coordinator(presnt : self)
    }
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        load(webView)
        webView.navigationDelegate = context.coordinator
        webViewState.webView = webView
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let newURL = webViewState.url else { return }

        if uiView.url != newURL {
            uiView.load(URLRequest(url: newURL))
        }
    }

    
    func load(_ uiView : WKWebView){
        guard let url = webViewState.url else { return }
        webViewState.update(with: true)
        uiView.load(URLRequest(url: url) )
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        var presnt : WebView
        
        init(presnt: WebView) {
            self.presnt = presnt
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print(#function)
            DispatchQueue.main.async {
                self.presnt.webViewState.update(with: true)
            }
          
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            print(#function)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
            print(#function)
            DispatchQueue.main.async {
                self.presnt.webViewState.update(with: false,with: error)
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print(#function)
            DispatchQueue.main.async {
                self.presnt.webViewState.update(with: false)
                self.presnt.webViewState.update(currentURL: webView.url, currentTitle: webView.title)
            }
        
        }
    }
}

#Preview {
    WebView(webViewState: WebViewStateViewModel())
}
