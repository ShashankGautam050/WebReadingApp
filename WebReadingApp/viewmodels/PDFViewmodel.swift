//
//  PDFViewmodel.swift
//  WebReadingApp
//
//  Created by Shashank Gautam on 31/01/26.
//

import Foundation
import Observation
import PDFKit

import Foundation
import Observation

@Observable
class PDFViewModel {
    
    var pdfFiles: [URL] = []
    
    init() {
        loadPdfFiles()
    }
    
    func loadPdfFiles() {
        let directory = URL.documentsDirectory
        
        do {
           let fileURLs = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            self.pdfFiles = fileURLs.filter { $0.pathExtension == "pdf" }
            
        } catch {
            print("error getting pdf file urls: \(error)")
        }
    }
    
    func delete(_ fileURL: URL) {
        do {
           try FileManager.default.removeItem(at: fileURL)
            loadPdfFiles()
        } catch {
            print("error deleting pdf: \(error)")
        }
    }
}
