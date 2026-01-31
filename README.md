##  App Features

###  Navigation Split View
The app uses `NavigationSplitView` to present a modern master-detail interface.  
Users can browse a list of reading items and view detailed content side-by-side, providing a smooth and adaptive reading experience across devices.

---

###  Adding New Reading Items
Users can add new items to their reading list by entering:
- A title
- A URL

New items are stored locally and appear instantly in the list.

---

###  Web Page Display (WKWebView)
Since SwiftUI does not provide a native web view, the app bridges UIKit and SwiftUI using:
- `WKWebView`
- `UIViewRepresentable`

This enables full web browsing support inside SwiftUI while handling navigation, loading states, and page metadata efficiently.

---

###  Local Data Storage & Persistence
The app persists user data locally using:
- `Codable` for data modeling
- JSON file storage for the reading list

Reading list metadata is saved in the **Application Support** directory, ensuring:
- Data persists after closing the app
- Metadata is not visible in the Files app

This follows Apple’s recommended data storage practices.

---

###  PDF Export & Viewing
Users can export any loaded web page as a PDF.

Features include:
- Generating PDFs directly from `WKWebView`
- Saving PDFs to the app’s **Documents** directory
- Viewing PDFs inside the app using **PDFKit**
- Bridging PDFKit into SwiftUI with `UIViewRepresentable`
- Accessing generated PDFs via the Files app

---

###  Share &  Delete Functionality
Each saved PDF supports:
- Sharing via AirDrop or Files
- Deletion, which removes the file from both the UI and disk storage

The app ensures storage remains in sync with user actions.

---

###  Project Organization & Architecture
The project follows the **MVVM architecture** and leverages:
- SwiftUI for UI
- ViewModels as the single source of truth
- Apple’s `@Observable` framework for efficient state management

This structure provides clean separation of concerns, reactive UI updates, and scalability.
