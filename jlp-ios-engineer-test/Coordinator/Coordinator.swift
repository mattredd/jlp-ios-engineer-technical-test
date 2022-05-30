//
//  Coordinator.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
