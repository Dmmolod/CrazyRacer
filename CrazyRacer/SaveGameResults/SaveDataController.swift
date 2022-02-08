//
//  SaveDataController.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 04.02.2022.
//

import Foundation
import UIKit

class SaveDataController {
    
    
    static var resultsPath: URL {
        get {
            let dirDocumentsURL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                                           .userDomainMask,
                                                                                           true).first!)
            return dirDocumentsURL.appendingPathComponent("results")
        }
    }
    
    var results: [ResultData]? {
        if let savedContent = FileManager.default.contents(atPath: SaveDataController.resultsPath.path) {
            return try? JSONDecoder().decode([ResultData].self, from: savedContent)
        }
        else { return nil }
    }
}


