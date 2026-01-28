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
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(.bordered)
                Button {
                    print("save btn clicked")
                } label: {
                    Text("Save")
                }
                .buttonStyle(.borderedProminent)

            }
        }
        .textFieldStyle(.roundedBorder)
        .padding()
    }
}

#Preview {
    ReadingItemEditor()
}
