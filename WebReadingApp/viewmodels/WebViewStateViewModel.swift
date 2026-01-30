//
//  WebViewStateViewModel.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 30/01/26.
//

import Foundation
import Observation
import WebKit

/// ViewModel that holds the complete state of the WKWebView
/// This is the single source of truth for SwiftUI
@Observable
class WebViewStateViewModel {

    // MARK: - URL State

    /// The URL SwiftUI wants the WebView to load
    /// Changing this triggers `updateUIView`
    var url: URL? = nil

    /// The URL that actually finished loading in WKWebView
    /// Used to prevent unnecessary reloads and detect redirects
    var currentURL: URL? = nil
    var successFullyGeneratePDFURL : URL? = nil
    // MARK: - Loading & Error State

    /// `true` while a page is loading
    /// Used to show / hide a loader
    var isLoading: Bool = false

    /// Holds loading or navigation errors
    /// Used to show error UI
    var error: Error? = nil

    // MARK: - Navigation State

    /// Whether WKWebView can navigate back
    var canGoBack: Bool = false

    /// Whether WKWebView can navigate forward
    var canGoForward: Bool = false

    // MARK: - WebKit Bridge

    /// Weak reference to WKWebView
    /// Allows SwiftUI to control navigation (back/forward/reload)
    /// Weak to avoid retain cycles
    weak var webView: WKWebView?

    // MARK: - Page Metadata

    /// Title of the currently loaded page
    var currentTitle: String? = nil

    // MARK: - Init

    /// Optional initial URL (useful for deep links or previews)
    init(url: URL? = nil) {
        self.url = url
    }

    // MARK: - Intent Methods (called by SwiftUI)

    /// Request to load a new URL
    /// Called when user taps a link, enters a URL, or opens a bookmark
    func update(_ url: URL) {
        self.url = url
        self.error = nil
    }

    /// User explicitly requests to open a URL again
    /// Forces reload even if the same URL was already loaded
    func userRequestedToOpen(_ url: URL) {
        self.url = url
        self.error = nil
        self.currentURL = nil
    }

    // MARK: - WebKit Callbacks (called from Coordinator)

    /// Updates loading state and optional error
    /// Called from WKNavigationDelegate
    func update(with isLoading: Bool, with error: Error? = nil) {
        self.isLoading = isLoading

        if let error = error {
            self.error = error
        }
    }

    /// Called when a page finishes loading
    /// Updates URL, title, and navigation state
    func update(currentURL url: URL?, currentTitle title: String?) {
        self.currentURL = url
        self.currentTitle = title
        updateNavigationState()
    }

    /// Syncs back/forward availability with WKWebView
    func updateNavigationState() {
        self.canGoBack = webView?.canGoBack ?? false
        self.canGoForward = webView?.canGoForward ?? false
    }

    // MARK: - User Actions (called by SwiftUI buttons)

    /// Navigate back if possible
    func goBack() {
        webView?.goBack()
    }

    /// Navigate forward if possible
    func goForward() {
        webView?.goForward()
    }

    /// Reload the current page
    func reload() {
        error = nil
        webView?.reload()
    }
    
    func createPDF() {
        guard let webView else { return }
        
        webView.createPDF { result in
            switch result {
            case .success(let data):
                self.saveToDisk(data)
                self.successFullyGeneratePDFURL = self.currentURL
            case .failure(let error):
                
                print("error having : \(error)")
                //TODO show error to the user
            }
        }
    }
  
    func saveToDisk(_ data : Data){
        let documentsURL = URL.documentsDirectory
        let title = webView?.title ?? "Untitled"
        let documentURL = documentsURL.appendingPathComponent("\(title).pdf")
        do {
           
            try data.write(to: documentURL)
            self.currentURL = documentURL
            print("success : \(documentURL.absoluteString)")
        } catch {
            print("error while saving the pdf to the disk")
        }
    }
}
