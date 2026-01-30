//
//  ReadingDataViewModel.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 29/01/26.
//

import Foundation
import Observation

@Observable
class ReadingDataViewModel{
    var readingList : [ReadingItem] = []
    
    init() {
        load()
    }
    func addNewReadingItem(title : String,urlString : String){
        guard let url = URL(string: urlString) else { return }
        //TODO show error to the user if url is not valid
        
        addNewReadingItem(title: title, url: url)
    }
    
    
    func addNewReadingItem(title : String,url : URL){
        //TODO show error to the user if url is not valid
        
        let newItem = ReadingItem(title: title,url: url)
        readingList.append(newItem)
        save()
    }
    
    func fileURL() -> URL {
        let directory = supportDirectory() ?? URL.documentsDirectory
        let url = directory.appendingPathComponent("readingList.json")
        return url
    }
    func supportDirectory() -> URL? {
        do {
            return try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

        } catch {
            print("error : \(error)")
            return nil
        }
    }
    func save() {
        // first convert swift date type to data(which is binary)
        
        do {
          let data = try JSONEncoder().encode(readingList)
            // create url for file
          let url = fileURL()
            // write data to file
            try data.write(to: url)
            print("file location : \(url.absoluteString)")
        } catch {
            print("error : \(error.localizedDescription)")
        }
      
       
    }
    
    func load() {
        let url = fileURL()
        do {
            let data = try Data(contentsOf: url)
            self.readingList = try JSONDecoder().decode([ReadingItem].self, from: data)
        } catch {
            print("error : \(error.localizedDescription)")
            useSampleData()
        }
    }
    
    func useSampleData(){
        self.readingList = ReadingItem.examples
    }
}
