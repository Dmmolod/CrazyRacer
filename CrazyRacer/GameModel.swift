//
//  GameModel.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 03.01.2022.
//

import UIKit

class GameModel {
    
    let fps: Double = 60
    var score = 0
    var counter = 0 {
        didSet {
            score = counter/10
        }
    }
    var obstaclesCount: Int = 1
}
