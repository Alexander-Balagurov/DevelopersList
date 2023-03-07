//
//  MainFlowController.swift
//  TestMiOS
//
//  Created by Alexander Balagurov on 03.03.2023.
//  Copyright © 2023 Adina Porea. All rights reserved.
//

import UIKit

private extension String {
    static let developersTabTitle = "Developers"
    static let personImageName = "person.2"
    static let personFillImageName = "person.2.fill"
}

final class MainFlowController: UIViewController {

    private let tabbarController = UITabBarController()
    private lazy var developersFlowController = makeDevelopersFlowController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension MainFlowController {

    func setup() {
        addChildController(tabbarController, to: view)
        tabbarController.setViewControllers([developersFlowController], animated: false)
    }

    func makeDevelopersFlowController() -> DevelopersFlowController {
        let fc = DevelopersFlowController()
        fc.tabBarItem = .init(
            title: .developersTabTitle,
            image: UIImage(systemName: .personImageName),
            selectedImage: UIImage(systemName: .personFillImageName)
        )

        return fc
    }
}
