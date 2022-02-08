//
//  ViewMenu.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 03.01.2022.
//

import UIKit

class ViewMenu: UIView {
    
    typealias TapButtonHandler = (UIButton) -> Void
        
    let startGameButton = UIButton()
    let resultGameButton = UIButton()
    let tapHandler: TapButtonHandler

    init(tapHandler: @escaping TapButtonHandler) {
        self.tapHandler = tapHandler
        super.init(frame: .zero)
        
        self.backgroundColor = .systemPurple
        self.setupUI()
        self.setupActionButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupActionButton() {
        self.startGameButton.addAction(UIAction(handler: { _ in
            self.tapHandler(self.startGameButton)
        }), for: .touchUpInside)
        
        self.resultGameButton.addAction(UIAction(handler: { _ in
            self.tapHandler(self.resultGameButton)
        }), for: .touchUpInside)
    }
    
    private func setupUI() {
        
        // setup result button
        
        self.startGameButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.startGameButton)
        self.startGameButton.backgroundColor = .systemBlue
        self.startGameButton.setTitle("Start game", for: .normal)
        self.startGameButton.setTitleColor(.white, for: .normal)
        self.startGameButton.layer.cornerRadius = 20
        
        // setup result button
        
        self.resultGameButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.resultGameButton)
        self.resultGameButton.backgroundColor = .systemBlue
        self.resultGameButton.setTitle("Results", for: .normal)
        self.resultGameButton.setTitleColor(.white, for: .normal)
        self.resultGameButton.layer.cornerRadius = 20

        // setup constraints
        
        NSLayoutConstraint.activate([
            self.startGameButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.startGameButton.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            self.startGameButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            
            self.resultGameButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.resultGameButton.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            self.resultGameButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
        ])

        
    }
    
}
