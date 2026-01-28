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
    
    
    
    @State private var selectedItem: ReadingItem? = nil
    var body: some View {
        
        NavigationSplitView {
           
        } detail: {
            if let selectedItem {
                Text(selectedItem.title)
            } else {
                ContentUnavailableView("Please select a book to read", image: "book")
            }
        }

    }
}

#Preview {
    ContentView()
}
