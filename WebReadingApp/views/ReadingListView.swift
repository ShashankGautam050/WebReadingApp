//
//  ReadingListView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 28/01/26.
//

import SwiftUI

struct ReadingListView: View {
    @Bindable var readingDataViewMmodel: ReadingDataViewModel
    @Binding var selectedItem: ReadingItem?
    @State private var isEditorPresented = false

    var body: some View {
        List(
            $readingDataViewMmodel.readingList,
            editActions: [.move, .delete],
            selection: $selectedItem
        ) { $item in

            ReadingItemView(readingItem: $item)
                .tag(item)
                .swipeActions(edge: .leading) {
                    Button {
                        $item.hasFinished.wrappedValue.toggle()
                    } label: {
                        Text($item.hasFinished.wrappedValue ? "Undo" : "Finish")
                    }
                }

        }
        .toolbar {
            Button {
                isEditorPresented.toggle()
            } label: {
                Image(systemName: "plus")
            }
            EditButton()
        }
        .sheet(isPresented: $isEditorPresented) {
            ReadingItemEditor(readingDataViewMmodel: readingDataViewMmodel)
                .presentationDetents([.medium])
        }
    }
}

fileprivate struct ReadingItemView : View {
    @Binding var readingItem: ReadingItem
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
        ReadingListView(readingDataViewMmodel: ReadingDataViewModel(), selectedItem: $selectedItem)
    }
}

//#Preview {
//    ReadingItemView()
//}
