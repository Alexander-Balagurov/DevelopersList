//
//  DevelopersFlowController.swift
//  TestMiOS
//
//  Created by Alexander Balagurov on 03.03.2023.
//  Copyright © 2023 Adina Porea. All rights reserved.
//

import UIKit

final class DevelopersFlowController: UIViewController {

    private let navigationC = UINavigationController()
    private lazy var developersViewController = makeDevelopersViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension DevelopersFlowController {

    func setup() {
        addChildController(navigationC, to: view)
        navigationC.setViewControllers([developersViewController], animated: false)
        navigationC.navigationBar.prefersLargeTitles = true
    }

    func makeDevelopersViewController() -> DevelopersViewController {
        let modelController = DevelopersModelController()
        let vc = DevelopersViewController(modelController: modelController)

        return vc
    }
}
