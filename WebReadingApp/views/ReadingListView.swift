//
//  ReadingListView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 28/01/26.
//

import SwiftUI

struct ReadingListView: View {
    @Bindable var readingDataViewMmodel : ReadingDataViewModel
    @Binding var selectedItem: ReadingItem?
    @State private var isEditorPresented : Bool = false
    
    @State var navigateToDetail = NavigationPath()
    var body: some View {
        NavigationStack(path : $navigateToDetail) {
            List(readingDataViewMmodel.readingList,selection: $selectedItem){ item in
                ReadingItemView(readingItem: item)
                    .onTapGesture {
                        navigateToDetail.append(item)
                    }
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
                ReadingItemEditor(readingDataViewMmodel: readingDataViewMmodel)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            .navigationDestination(for: ReadingItem.self) { item in
                ReadingDetailView(readingItem: item)
            }
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
        ReadingListView(readingDataViewMmodel: ReadingDataViewModel(), selectedItem: $selectedItem)
    }
}

//#Preview {
//    ReadingItemView()
//}
