//
//  PDFCell.swift
//  SetGov
//
//  Created by Francis Zamora on 8/16/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import PDFReader

class PDFCell: UITableViewCell {
    func openPDF() {
        
        let remotePDFDocumentURLPath = "http://devstreaming.apple.com/videos/wwdc/2016/201h1g4asm31ti2l9n1/201/201_internationalization_best_practices.pdf"
        let remotePDFDocumentURL = URL(string: remotePDFDocumentURLPath)!
        let document = PDFDocument(url: remotePDFDocumentURL)
    }
}
