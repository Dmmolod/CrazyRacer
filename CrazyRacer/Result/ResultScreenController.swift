//
//  ResultScreenController.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 04.02.2022.
//

import Foundation
import UIKit

class ResultScreenController: UIViewController {
    
    enum SortedType {
        case date, score
    }
    
    let resultView = ResultView()
    var currentSortedType: SortedType = .score
    
    override func loadView() {
        self.view = self.resultView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down.square"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(self.sortedResults))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupResultsData()
    }
    
    @objc
    func sortedResults() {
        switch currentSortedType {
        case .date:
            self.setupResultsData(.score)
            self.currentSortedType = .score
        case .score:
            self.setupResultsData(.date)
            self.currentSortedType = .date
        }
    }
    
    func setupResultsData(_ sortedType: SortedType = .score) {
        if let test = FileManager.default.contents(atPath: SaveDataController.resultsPath.path) {
            
            let result = try? JSONDecoder().decode([ResultData].self, from: test)
            
            var resultString = String()
            
            result?.sorted(by: {
                switch sortedType {
                case .date:
                   return  $0.date > $1.date
                case .score:
                    return $0.score > $1.score
                }
                
            }).forEach({ resData in
                
                let dataTest = DateFormatter()
                dataTest.dateStyle = .long
                dataTest.timeStyle = .short
                dataTest.locale = Locale(identifier: "ru")
                
                resultString += "\(dataTest.string(from: resData.date))\t|\t \(resData.score) очков\n"
            })
            self.resultView.text = resultString
        }
        else { print("Fail") }
    }
}
