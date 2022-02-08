//
//  UserActionsDelegate.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 04.02.2022.
//

import Foundation
import UIKit

protocol UserActionsDelegate: AnyObject {
    func action(_ viewController: UIViewController, tappedButton: UIButton?)
}
