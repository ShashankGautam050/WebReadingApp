//
//  ReadingItem.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 28/01/26.
//

import Foundation
import Observation

@Observable
class ReadingItem  : Identifiable,Hashable,Equatable,Codable{
    
    
    var title : String
    var url : URL?
    let creationDate : Date
    var hasFinished : Bool = false
    let id : UUID
    
    init(title: String, url: URL? = nil,creationDate : Date = Date(), hasFinished: Bool = false,id : UUID = UUID()) {
        self.title = title
        self.url = url
        self.creationDate = creationDate
        self.hasFinished = hasFinished
        self.id = id
    }
    
    
    // If you implement hash(into:) manually, you must also implement the == operator (Equatable protocol) using the same properties. If two objects have the same id, they must be considered equal:
    
    static func == (lhs: ReadingItem, rhs: ReadingItem) -> Bool {
        lhs.id == rhs.id
    }
    
    // this func making custom object "readingItem" uniquely identifiable by considering id as unique due to this data changes and ui changes performs fast
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
    
    // Mark Preview Helper
    static var example : ReadingItem {
        ReadingItem(title: "Apple",url: URL(string: "https://www.apple.com"))
    }
    
    static var examples : [ReadingItem] {
        [ ReadingItem(title: "Apple",url: URL(string: "https://www.apple.com")),
          ReadingItem(title: "SwiftyPlace",url: URL(string: "https://www.swiftyplace.com/blog/swiftui-lazyvgrid-and-lazyhgrid"),hasFinished: true),
          ReadingItem(title: "Apple",url: URL(string: "https://www.apple.com")),
          ReadingItem(title: "UIKitVSSwiftUI",url: URL(string: "https://nilcoalescing.com/blog/CustomSizeForUIViewsWrappedInUIViewRepresentable/"))
        ]
    }
}
