//
//  ViewController.swift
//  TestMiOS
//
//  Created by Adina porea on 24/05/16.
//  Copyright © 2016 Adina Porea. All rights reserved.
//

import UIKit
import BDataProvider

class ViewController: UIViewController {

    private let team = TeamProvider()

    override func viewDidLoad() {
        super.viewDidLoad()

        team.teamUIDelegate = self
    }

}

extension ViewController: TeamDataUpdaterDelegate {
    func teamListShouldBeRefreshed() {
        print("teamListShouldBeRefreshed")
    }

    func informationForMemberWithIDhasChanged(memberID: String) {
        print("informationForMemberWithIDhasChanged")
        print(memberID)
    }
}
