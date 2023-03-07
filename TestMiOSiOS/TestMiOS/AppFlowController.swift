//
//  AppFlowController.swift
//  TestMiOS
//
//  Created by Alexander Balagurov on 03.03.2023.
//  Copyright © 2023 Adina Porea. All rights reserved.
//

import UIKit

final class AppFlowController: UIViewController {

    private var mainFlowController: MainFlowController?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension AppFlowController {

    func setup() {
        let mainFC = MainFlowController()
        mainFlowController = mainFC
        addChildController(mainFC, to: view)
    }
}
