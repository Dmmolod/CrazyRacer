//
//  ResultView.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 04.02.2022.
//

import Foundation
import UIKit

class ResultView: UIView {
    
    private let scrollResultsView = UIScrollView()
    private let lable = UILabel()
    
    var text: String {
        set {
            if self.lable.text != nil {
                self.lable.text! = "Your results:\n\(newValue)"
            }
        }
        
        get {
            return self.lable.text ?? "Empty"
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemMint
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.scrollResultsView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.scrollResultsView)
        self.lable.text = "Your results:"
        self.lable.layer.shadowOpacity = 0.5
        self.lable.textAlignment = .left
        self.lable.numberOfLines = 0
        self.lable.translatesAutoresizingMaskIntoConstraints = false
        self.scrollResultsView.addSubview(self.lable)
        
        NSLayoutConstraint.activate([
            self.lable.topAnchor.constraint(equalTo: self.scrollResultsView.topAnchor),
            self.lable.centerXAnchor.constraint(equalTo: self.scrollResultsView.centerXAnchor),
            self.lable.bottomAnchor.constraint(equalTo: self.scrollResultsView.bottomAnchor),
            
            self.scrollResultsView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scrollResultsView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scrollResultsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            self.scrollResultsView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
