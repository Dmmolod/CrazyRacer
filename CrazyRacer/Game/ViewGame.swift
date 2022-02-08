//
//  ViewGame.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 03.01.2022.
//

import UIKit
import Foundation

class ViewGame: UIView {
    
    var background = UIView()
    var roads = (first: UIImageView(),
                 second: UIImageView())
    var car = UIImageView()
    var obstacles = [UIImageView]()
    private var swipeHandler: (UISwipeGestureRecognizer.Direction) -> Void
    var animateConstraint = (firstRoad: NSLayoutConstraint(),
                             car: NSLayoutConstraint(),
                             obstacles: [(x: NSLayoutConstraint, y: NSLayoutConstraint)]())
    private var randomPosition: (x: CGFloat,
                                 y: CGFloat) {
        let xRandom: CGFloat = [-70,-60,-40,-20,0,20,40,60,70].shuffled().first ?? 0
        let yRandom: CGFloat = [-300,-200,-150].shuffled().first ?? 0
        return (xRandom,yRandom)
    }
    init(handler: @escaping (UISwipeGestureRecognizer.Direction) -> Void) {
        self.swipeHandler = handler
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBrown
        self.setupSwipeGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func roadMove() {
        self.animateConstraint.firstRoad.constant += 1
        if !self.background.bounds.intersects(self.roads.first.frame) {
            self.animateConstraint.firstRoad.constant = 0
        }
    }
    
    @objc
    func carMove(sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case .left: self.swipeHandler(.left)
        case .right: self.swipeHandler(.right)
        default: print("Error: add a new swipe direction")
        }
    }
    
    func currentPositionGameObjects() -> (carBorders: (left: CGFloat, right: CGFloat), roadBorders: (left: CGFloat, right: CGFloat)) {
        let carBorders = (left: self.car.frame.minX,
                          right: self.car.frame.maxX)
        let roadBorders = (left: self.background.bounds.minX,
                           right: self.background.bounds.maxX)
        return (carBorders,roadBorders)
    }
    
    func createGameSpace(obstaclesCount: Int) {
        self.background = self.setupBackgroundSpace()
        
        self.roads.first = self.setupRoads(superView: background)
        self.roads.second = self.setupRoads(superView: background)
        self.car = self.setupCar(superView: background)
        self.obstacles = self.setupObstacles(count: obstaclesCount)
        
        // Дополнительная настройка констреинтов
        self.roads.second.bottomAnchor.constraint(equalTo: self.roads.first.topAnchor).isActive = true
        self.animateConstraint.firstRoad = self.roads.first.centerYAnchor.constraint(equalTo: self.background.centerYAnchor, constant: 0)
        self.animateConstraint.firstRoad.isActive = true
    }
    
    private func setupSwipeGestureRecognizers() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.carMove(sender:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.carMove(sender:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.addGestureRecognizer(leftSwipe)
        self.addGestureRecognizer(rightSwipe)
    }
    
    private func setupCar(superView: UIView) -> UIImageView {
        let car = UIImageView(image: UIImage(named: "car"))
        car.contentMode = .scaleAspectFill
        
        car.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(car)
        NSLayoutConstraint.activate([
            car.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -50),
            car.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 1/9),
            car.heightAnchor.constraint(equalTo: car.widthAnchor, constant: 20)
        ])
        self.animateConstraint.car = car.centerXAnchor.constraint(equalTo: self.background.centerXAnchor, constant: 0)
        self.animateConstraint.car.isActive = true
        return car
    }
    
    private func setupRoads(superView: UIView) -> UIImageView {
        let road = UIImageView(image: UIImage(named: "road"))
        road.contentMode = .scaleToFill
        
        road.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(road)
        NSLayoutConstraint.activate([
            road.heightAnchor.constraint(equalTo: superView.heightAnchor),
            road.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
            road.widthAnchor.constraint(equalTo: superView.widthAnchor)
        ])
        return road
    }
    
    private func setupObstacles(count: Int) -> [UIImageView] {
        var obstacles = [UIImageView]()
        
        for index in 0..<count {
            let obstacle = UIImageView(image: UIImage(named: "rock"))
            obstacle.contentMode = .scaleAspectFill
            
            obstacle.translatesAutoresizingMaskIntoConstraints = false
            self.background.addSubview(obstacle)
            
            if self.animateConstraint.obstacles.isEmpty {
                self.animateConstraint.obstacles.append((x: obstacle.centerXAnchor.constraint(equalTo: self.background.centerXAnchor, constant: self.randomPosition.x),
                                                         y: obstacle.bottomAnchor.constraint(equalTo: self.background.topAnchor, constant: -50)))
            }
            else {
                self.animateConstraint.obstacles.append((x: obstacle.centerXAnchor.constraint(equalTo: self.background.centerXAnchor, constant: self.randomPosition.x),
                                                         y: obstacle.bottomAnchor.constraint(equalTo: obstacles.last!.topAnchor, constant: self.randomPosition.y)))
            }
            self.animateConstraint.obstacles[index].x.isActive = true
            self.animateConstraint.obstacles[index].y.isActive = true
        
            
            NSLayoutConstraint.activate([
                obstacle.widthAnchor.constraint(equalToConstant: [30,40,60].shuffled().first ?? 0),
                obstacle.heightAnchor.constraint(equalTo: obstacle.widthAnchor, constant: 20)
            ])
            obstacles.append(obstacle)
        }
        return obstacles
    }
    
    private func setupBackgroundSpace() -> UIView {
        let background = UIView()
        background.backgroundColor = .lightGray
        background.layer.cornerRadius = 20
        background.clipsToBounds = true
        background.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(background)
        
        NSLayoutConstraint.activate([
            background.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            background.widthAnchor.constraint(equalTo: self.widthAnchor),
            background.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
        return background
    }
}
