//
//  ReadingItemEditor.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 29/01/26.
//

import SwiftUI

struct ReadingItemEditor: View {
    @State var title : String = ""
    @State var url : String = ""
    @Bindable var readingDataViewMmodel : ReadingDataViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            HStack {
                Text("Create new reading item")
                    .font(.title)
                Spacer()
            }
            HStack {
                Text("Title:")
                TextField("Title", text: $title)
                        
                    
            }
            
            HStack {
                Text("URL:")
                TextField("URL", text: $url)
                    
            }
            
            HStack {
                Spacer()
                Button {
                    print("cancel btn clicked")
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.title2)
                }
                
                .buttonStyle(.bordered)
                Button {
                    print("save btn clicked")
                    readingDataViewMmodel.addNewReadingItem(title: title, urlString: url)
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.title2)
                }
                .buttonStyle(.borderedProminent)

            }
        }
        .textFieldStyle(.roundedBorder)
        .padding()
    }
}

#Preview {
    ReadingItemEditor( readingDataViewMmodel: ReadingDataViewModel())
}
