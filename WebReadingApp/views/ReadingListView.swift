//
//  ReadingListView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 28/01/26.
//

import SwiftUI

struct ReadingListView: View {
    let items : [ReadingItem]
    @Binding var selectedItem: ReadingItem?
    @State private var isEditorPresented : Bool = false
    var body: some View {
        List(items,selection: $selectedItem){ item in
            ReadingItemView(readingItem: item)
        }
        .toolbar {
            Button {
                print("clicked")
                isEditorPresented.toggle()
            } label: {
                Image(systemName: "plus")
            }

        }
        .sheet(isPresented: $isEditorPresented) {
            ReadingItemEditor()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        
    }
}

fileprivate struct ReadingItemView : View {
    let readingItem : ReadingItem
    var body : some View {
        HStack(alignment :.firstTextBaseline){
            Image(systemName: readingItem.hasFinished ? "book.fill" : "book")
                .foregroundStyle(.green)
            VStack(alignment: .leading,spacing: 8){
                Text(readingItem.title)
                Text(readingItem.creationDate.formatted())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
       
    }
   
}

#Preview {
    @State @Previewable var selectedItem : ReadingItem?
    NavigationStack {
        ReadingListView(items: ReadingItem.examples, selectedItem: $selectedItem)
    }
}

//#Preview {
//    ReadingItemView()
//}
