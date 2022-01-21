//
//  NavigationController.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 03.01.2022.
//

import UIKit

class NavigationController: UINavigationController {
    
    var navController: UINavigationController?
        
    init() {
        super.init(nibName: nil, bundle: nil)

        self.pushViewController(MenuViewController(handler: self.startGame), animated: true)
    }
    
    func startGame() {
        self.pushViewController(GameViewController(backToMenuHandler: self.menu), animated: false)
    }
    func menu() {
        // Возврат в меню
        self.popToRootViewController(animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
