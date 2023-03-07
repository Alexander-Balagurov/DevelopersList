//
//  DevelopersViewController.swift
//  TestMiOS
//
//  Created by Alexander Balagurov on 04.03.2023.
//  Copyright © 2023 Adina Porea. All rights reserved.
//

import UIKit
import BDataProvider

final class DevelopersViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    private let teamProvider = TeamProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        teamProvider.teamUIDelegate = self
    }
}

extension DevelopersViewController: TeamDataUpdaterDelegate {

    func teamListShouldBeRefreshed() {
        print("teamListShouldBeRefreshed")
        teamProvider.provideTeamMemberIDs { list in
            print(list)
        }
    }

    func informationForMemberWithIDhasChanged(memberID: String) {
        print("informationForMemberWithIDhasChanged")
        teamProvider.provideMemberInformationForID(id: memberID) { developer in
            print(developer?.photoURL)
        }
    }
}
