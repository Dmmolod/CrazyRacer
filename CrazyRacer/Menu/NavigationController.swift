//
//  NavigationController.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 03.01.2022.
//

import UIKit

class NavigationController: UINavigationController {
    
    let menuController = MenuViewController()
    var gameController = GameViewController()
    let resultController = ResultScreenController()
    
    let saveDataController = SaveDataController()
    
    init() {
        super.init(rootViewController: self.menuController)
        self.menuController.delegate = self
//        self.pushViewController(self.menuController, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startGame() {
        self.gameController = GameViewController()
        self.gameController.delegate = self
        self.gameController.saveDataDelegate = self.saveDataController
        self.pushViewController(self.gameController, animated: false)
    }
    func menu() {
        // Возврат в меню
        self.popToRootViewController(animated: true)
    }
    
    func resultScreen() {
        self.pushViewController(self.resultController, animated: true)
    }
}

extension NavigationController: UserActionsDelegate {  // Я совсем не понимаю как тут сделать логику по другому, и как нужно оформить в этом случае делегат
    func action(_ viewController: UIViewController, tappedButton: UIButton?) {
        switch viewController {
        case self.menuController:
            switch tappedButton {
            case self.menuController.viewMenu.startGameButton: self.startGame()
            case self.menuController.viewMenu.resultGameButton: self.resultScreen()
            default: return
            }
        case self.gameController: self.menu()
        case (let someViewController): print("Unknown view controller:\n------------\n\(someViewController)\n------------")
        }
        
    }
    
}
