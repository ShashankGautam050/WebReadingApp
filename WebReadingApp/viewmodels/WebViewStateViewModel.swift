//
//  WebViewStateViewModel.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 30/01/26.
//

import Foundation
import Observation
import WebKit

@Observable
class WebViewStateViewModel {
    
    var url : URL? = nil
    var isLoading : Bool = false
    var error: Error? = nil
    var currentURL : URL? = nil
    
    var canGoBack : Bool = false
    var canGoForward : Bool = false
    
    weak var webView : WKWebView?
    var currentTitle : String? = nil
    init(url : URL? = nil){
        self.url = url
    }
    func update(_ url : URL){
        self.url = url
        self.error = nil
    }
    func update(with isLoading : Bool,with error : Error? = nil ) {
        self.isLoading = isLoading
        if let error = error {
            self.error = error
        }
    }
    func userRequestedToOpen(_ url: URL) {
            self.url = url
            self.error = nil
            self.currentURL = nil
        }
    func update(currentURL url : URL?,currentTitle title : String?){
        self.currentURL = url
        self.currentTitle = title
        updateNavigationState()
    }
    func updateNavigationState() {
           self.canGoBack = webView?.canGoBack ?? false
           self.canGoForward = webView?.canGoForward ?? false
       }
    func goBack(){
        webView?.goBack()
    }
    func goForward(){
        webView?.goForward()
    }
    func reload(){
        webView?.reload()
    }
}
