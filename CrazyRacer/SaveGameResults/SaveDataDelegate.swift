//
//  SaveDataDelegate.swift
//  CrazyRacer
//
//  Created by Дмитрий Молодецкий on 04.02.2022.
//

import Foundation
import UIKit

protocol SaveDataDelegate: AnyObject {
    func updateDataOfResult(_ viewController: UIViewController, scoreToSave score: Int, dateOfStart: Date)
}
