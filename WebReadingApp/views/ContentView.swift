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
    
    @State private var readingDataViewModel = ReadingDataViewModel()
    @State private var selectedItem: ReadingItem? = nil
    
    @Environment(\.scenePhase) var screenPhase
    var body: some View {
         NavigationSplitView {
            ReadingListView(readingDataViewMmodel: readingDataViewModel, selectedItem: $selectedItem)
        } detail: {
            if let selectedItem {
                Text(selectedItem.title)
            } else {
                ContentUnavailableView("Please select a book to read", image: "book")
            }
        }
        .onChange(of: screenPhase) { oldValue, newValue in
            switch newValue {
            case .active: readingDataViewModel.load()
            case .inactive,.background : readingDataViewModel.save()
            @unknown default: break
            }
        }

    }
}

#Preview {
    ContentView()
}
