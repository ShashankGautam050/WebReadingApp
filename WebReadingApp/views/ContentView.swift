//
//  ContentView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 28/01/26.
//

import SwiftUI

struct ContentView: View {
    //   make all the variables,instances,state
   //    and binding outside of the body variable
    enum NavigationSelcetion: Identifiable,Hashable {
        case pdf(url : URL)
        case readingList(item : ReadingItem)
        var id : String
        {
            switch self {
            case .pdf(url: let url):
                return url.absoluteString
            case .readingList(item: let item):
                return item.id.uuidString
            }
        }
    }
    @State private var isEditorPresented = false
    @State private var readingDataViewModel = ReadingDataViewModel()
    @State private var selectedItem: NavigationSelcetion? = nil
    @State private var pdfFileViewModel = PDFViewModel()
    @State private var webstate = WebViewStateViewModel()
    @Environment(\.scenePhase) var screenPhase
    var body: some View {
         NavigationSplitView {
             List(selection: $selectedItem) {
                 PDFSectionView(pdfFileViewModel: pdfFileViewModel)
                 
                 ReadingListSectionView(readingDataViewMmodel: readingDataViewModel)
             }
             .toolbar {
                 Button {
                     isEditorPresented.toggle()
                 } label: {
                     Image(systemName: "plus")
                 }
                 EditButton()
             }
        } detail: {
            if let selectedItem {
                switch selectedItem {
                case .pdf(let url):
                    PDFViewer(fileURL: url, pdfViewmodel: pdfFileViewModel,webstate: webstate, pdf: pdfFileViewModel)
                case .readingList(let item):
                    ReadingDetailView(readingItem: item, readingDataViewModel: readingDataViewModel, pdf: pdfFileViewModel)
                }
               
            } else {
                ContentUnavailableView("Please select a book to read", image: "book.pages.fill")
            }
        }
        .sheet(isPresented: $isEditorPresented) {
            ReadingItemEditor(readingDataViewMmodel: readingDataViewModel)
                .presentationDetents([.medium])
        }
       
        .onChange(of: screenPhase) { oldValue, newValue in
            switch newValue {
            case .active:
                readingDataViewModel.load()
               
            case .inactive,.background :
                readingDataViewModel.save()
                pdfFileViewModel.loadPdfFiles()
            @unknown default: break
            }
        }

    }
}

#Preview {
    ContentView()
}
