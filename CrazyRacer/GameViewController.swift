//
//  GameViewController.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 03.01.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    lazy var gameView = ViewGame(handler: self.carMove(sideToMove:))
    let gameModel = GameModel()
    var backToMenuHandler: () -> Void
    var gameTimer: Timer?
    
    init(backToMenuHandler: @escaping () -> Void) {
        self.backToMenuHandler = backToMenuHandler
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setDifficultAlert()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setDifficultAlert() {
        let alert = UIAlertController(title: "Difficult", message: "Set game's difficult (integer)", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "from 5 to 99"
            textField.textColor = .red
        }
        alert.addAction(UIAlertAction(title: "Set", style: .destructive, handler: { _ in
            guard let text = alert.textFields?.first?.text else { self.setDifficultAlert(); return }
            let userInteger = Int(text)
            if userInteger == nil {
                self.setDifficultAlert()
            }
            else {
                if userInteger! < 5 || userInteger! > 99 {
                    self.setDifficultAlert()
                    return
                }
                self.gameModel.obstaclesCount = userInteger!
                self.startGame()
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func startGame() {
        self.gameView.createGameSpace(obstaclesCount: self.gameModel.obstaclesCount)
        self.gameTimer = Timer.scheduledTimer(timeInterval: 1/self.gameModel.fps, target: self, selector: #selector(self.gameLogic), userInfo: nil, repeats: true)
    }
    
    func stopGame() {
        self.gameTimer?.invalidate()
        self.gameTimer = nil
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
            self.title = "score: \(self.gameModel.score)"
            self.gameView.roadMove()
        }
        else {
            self.gameOverAlert()
        }
    }
    
    func carMove(sideToMove: UISwipeGestureRecognizer.Direction) {
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
    
    func gameOverAlert() {
        self.stopGame()
        let alert = UIAlertController(title: "Game over", message: "You score: \(self.gameModel.score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to menu", style: .destructive, handler: { _ in
            self.backToMenuHandler()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func gameWinAlert() {
        self.stopGame()
        let alert = UIAlertController(title: "You'r WIN!", message: "Final score: \(self.gameModel.score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to menu", style: .cancel, handler: { _ in
            self.backToMenuHandler()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func loadView() {
        self.view = self.gameView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopGame()
    }
}
