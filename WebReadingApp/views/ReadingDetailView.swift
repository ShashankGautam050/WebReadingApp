//
//  ReadingDetailView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 28/01/26.
//

import SwiftUI

struct ReadingDetailView: View {
    
    let readingItem : ReadingItem
    var body: some View {
        Text(readingItem.url?.absoluteString ?? "")
    }
}

#Preview {
    ReadingDetailView(readingItem: ReadingItem.example)
}
