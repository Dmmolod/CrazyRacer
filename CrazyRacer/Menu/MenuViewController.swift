//
//  MenuViewController.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 03.01.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    weak var delegate: UserActionsDelegate?
    
    lazy var viewMenu = ViewMenu(tapHandler: self.tapButtonHandler(tappedNutton:))
    
    override func loadView() {
        self.title = "Menu"
        self.view = self.viewMenu
    }
    
    func tapButtonHandler(tappedNutton button: UIButton) {
        switch button {
        case self.viewMenu.resultGameButton:
            print("result")
            self.delegate?.action(self, tappedButton: button)
        case self.viewMenu.startGameButton:
            self.delegate?.action(self, tappedButton: button)
        case (let someButtomn): print("Unknown button: \(someButtomn)")
        }
    }
}
