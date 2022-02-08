//
//  GameViewController.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 03.01.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    weak var delegate: UserActionsDelegate?
    weak var saveDataDelegate: SaveDataDelegate?
    
    lazy var gameView = ViewGame(handler: self.carMove(sideToMove:))
    let gameModel = GameModel()
    var gameTimer: Timer?
    var carState: State?
    
    func startGame() {
        self.gameView.createGameSpace(obstaclesCount: self.gameModel.obstaclesCount)
        self.gameTimer = Timer.scheduledTimer(timeInterval: 1/self.gameModel.fps, target: self, selector: #selector(self.gameLogic), userInfo: nil, repeats: true)
    }
    
    func stopGame() {
        self.gameTimer?.invalidate()
        self.gameTimer = nil
        self.delegate?.action(self, tappedButton: nil)
    }
    
    @objc
    func gameLogic()  {
        if let lastObstacleMinY = self.gameView.obstacles.last?.frame.minY {
            self.gameView.animateConstraint.obstacles.first?.y.constant += 1
            if lastObstacleMinY > self.gameView.car.frame.maxY + 20 {
                self.gameWinAlert()
            }
        }
        
        self.gameModel.counter += 1
        let roadBorders = self.gameView.currentPositionGameObjects().roadBorders
        let carBorders = self.gameView.currentPositionGameObjects().carBorders
        var carCrashOfObstacles: Bool {
            var flag = false
            self.gameView.obstacles.forEach { obstacle in
                if obstacle.frame.intersects(self.gameView.car.frame) {
                    flag = true
                }
            }
            return flag
        }
        if carBorders.left > roadBorders.left + 50 && carBorders.right < roadBorders.right - 50 && !carCrashOfObstacles{
            self.carState = .normal
            self.title = "score: \(self.gameModel.score)"
            self.gameView.roadMove()
        }
        else {
            self.gameOverAlert()
        }
    }
    
    func carMove(sideToMove: UISwipeGestureRecognizer.Direction) {
        if self.carState == .normal {
            switch sideToMove {
            case .left:
                self.gameView.animateConstraint.car.constant -= 20
                UIView.animate(withDuration: 0.3) {
                    self.gameView.layoutIfNeeded()
                }
            case .right:
                self.gameView.animateConstraint.car.constant += 20
                UIView.animate(withDuration: 0.3) {
                    self.gameView.layoutIfNeeded()
                }
            default: return
            }
        }
    }
    
    func gameOverAlert() {
        let alert = UIAlertController(title: "Game over", message: "You score: \(self.gameModel.score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to menu", style: .destructive, handler: { _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
        self.stopGame()
    }
    
    func gameWinAlert() {
        let alert = UIAlertController(title: "You'r WIN!", message: "Final score: \(self.gameModel.score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to menu", style: .cancel, handler: { _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
        self.stopGame()
    }
    
    override func loadView() {
        self.view = self.gameView
        self.startGame()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopGame()
        self.saveDataDelegate?.updateDataOfResult(self, scoreToSave: self.gameModel.score,
                                                  dateOfStart: Date.now)
    }
}
