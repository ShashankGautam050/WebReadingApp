//
//  ReadingListView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 28/01/26.
//

import SwiftUI

struct ReadingListSectionView: View {
    @Bindable var readingDataViewMmodel: ReadingDataViewModel
//    @Binding var selectedItem: ReadingItem?
   

    var body: some View {
            Section("Reading list") {
                ForEach(
                    $readingDataViewMmodel.readingList,
                    editActions: [.move, .delete]
                ) { $item in
                    
                    ReadingItemView(readingItem: $item)
                        .tag(ContentView.NavigationSelcetion.readingList(item: item))
                        .swipeActions(edge: .leading) {
                            Button {
                                $item.hasFinished.wrappedValue.toggle()
                            } label: {
                                Text($item.hasFinished.wrappedValue ? "Undo" : "Finish")
                            }
                            .tint(item.hasFinished ? .gray : .green)
                        }
                    
                }
                
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
        List {
            ReadingListSectionView(readingDataViewMmodel: ReadingDataViewModel())
        }
        
    }
}

//#Preview {
//    ReadingItemView()
//}
