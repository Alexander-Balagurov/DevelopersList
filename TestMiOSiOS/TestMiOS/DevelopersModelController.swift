//
//  DevelopersModelController.swift
//  TestMiOS
//
//  Created by Alexander Balagurov on 04.03.2023.
//  Copyright © 2023 Adina Porea. All rights reserved.
//

import Foundation
import BDataProvider

final class DevelopersModelController {

    private let teamProvider: TeamProvider

    init() {
        teamProvider = TeamProvider()
        teamProvider.teamUIDelegate = self
    }
}

extension DevelopersModelController: TeamDataUpdaterDelegate {

    func teamListShouldBeRefreshed() {

    }

    func informationForMemberWithIDhasChanged(memberID: String) {
        
    }
}
