//
//  ViewMenu.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 03.01.2022.
//

import UIKit

class ViewMenu: UIView {

    init(handlerStartGame: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemPurple
        
        let startGameButton = UIButton(primaryAction: UIAction { _ in
            handlerStartGame()
        })
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(startGameButton)
        startGameButton.backgroundColor = .systemBlue
        startGameButton.setTitle("Start game", for: .normal)
        startGameButton.setTitleColor(.white, for: .normal)
        startGameButton.layer.cornerRadius = 20

        NSLayoutConstraint.activate([
            startGameButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startGameButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            startGameButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
