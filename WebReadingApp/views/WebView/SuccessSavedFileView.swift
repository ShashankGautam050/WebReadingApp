//
//  SuccessSavedFileView.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 30/01/26.
//

import SwiftUI

struct SuccessSavedFileView: View {
    let url : URL
    var body: some View {
        Label("Saved file to : \(url.lastPathComponent)",systemImage: "checkmark.circle.fill")
            .padding()
            .background(Color(.systemGreen))
            .cornerRadius(10)
            .shadow(radius: 5)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
            .padding(50)
            .padding(.bottom,0)
            .transition(.move(edge: .bottom))
    }
}

#Preview {
    SuccessSavedFileView(url: URL(string: "file:///Users/shashankgautam/Library/Developer/CoreSimulator/Devices/4762F313-9C68-44DF-A9F6-EC6B4B1831E0/data/Containers/Data/Application/8932E152-94E9-4399-AEBD-C2D42ED1297B/Documents/title.pdf")!)
}
