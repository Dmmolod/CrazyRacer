//
//  MenuViewController.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 03.01.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    lazy var viewMenu = ViewMenu(handlerStartGame: self.startGame)
    var flag: Bool?
    var navigationHandler: () -> Void
    
    init(handler: @escaping () -> Void) {
        self.navigationHandler = handler

        super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.title = "Menu"
        self.view = self.viewMenu
    }
    
    func startGame() {
        self.navigationHandler()
    }
}
