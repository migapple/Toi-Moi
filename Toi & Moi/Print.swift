//
//  Print.swift
//  
//
//  Created by Michel Garlandat on 10/02/2017.
//
//

import Foundation
import UIKit

func print() {
    let printController = UIPrintInteractionController.shared
    let printInfo = UIPrintInfo(dictionary: nil)
    printInfo.jobName = "print job"
    printController.printInfo = printInfo
    
    let format = UIMarkupTextPrintFormatter(markupText: "Element a imprimer")
    format.perPageContentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
    printController.printFormatter = format
    printController.present(animated: true, completionHandler: nil)
}

