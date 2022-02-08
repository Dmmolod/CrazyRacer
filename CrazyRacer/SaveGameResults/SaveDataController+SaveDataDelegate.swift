//
//  SaveDataController+SaveDataDelegate.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 08.02.2022.
//

import Foundation
import UIKit

extension SaveDataController: SaveDataDelegate {
    
    func updateDataOfResult(_ viewController: UIViewController, scoreToSave score: Int, dateOfStart date: Date) {

        let resultPath = SaveDataController.resultsPath.path
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        let currentData = ResultData(date: date, score: score)
        guard var savedData = self.results else {
            FileManager.default.createFile(atPath: resultPath,
                                           contents: try? jsonEncoder.encode([currentData]),
                                           attributes: nil)
            return
        }
        savedData.append(currentData)
        try? FileManager.default.removeItem(atPath: resultPath)
        
        FileManager.default.createFile(atPath: resultPath,
                                       contents: try? jsonEncoder.encode(savedData),
                                       attributes: nil)
    }
}

