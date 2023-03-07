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

    private let teamProvider = TeamProvider()
    lazy var developers: [Developer] = configureDevelopersList()

    func setTeamUIDelegate(_ delegate: TeamDataUpdaterDelegate) {
        teamProvider.teamUIDelegate = delegate
    }

    func provideMemberInformation(for id: String, completion: (Developer?) -> Void) {
        teamProvider.provideMemberInformationForID(id: id, completion: completion)
    }
}

private extension DevelopersModelController {

    func configureDevelopersList() -> [Developer] {
        var developersList: [Developer] = []
        teamProvider.provideTeamMemberIDs { list in
            list.forEach {
                provideMemberInformation(for: $0) { developer in
                    guard let developer else { return }

                    developersList.append(developer)
                }
            }
        }

        return developersList
    }
}
