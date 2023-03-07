//
//  DevelopersViewController.swift
//  TestMiOS
//
//  Created by Alexander Balagurov on 04.03.2023.
//  Copyright © 2023 Adina Porea. All rights reserved.
//

import UIKit
import BDataProvider

private extension String {
    static let navigationTitle = "Developers"
}

final class DevelopersViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    private let teamProvider = TeamProvider()
    private var developers: [BDataProvider.Developer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension DevelopersViewController {

    func setup() {
        title = .navigationTitle
        view.backgroundColor = .white
        teamProvider.teamUIDelegate = self
        setupTableView()
        configureDevelopersList()
    }

    func setupTableView() {
        tableView.layout(in: view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(DevelopersTableViewCell.self)
    }

    func configureDevelopersList() {
        teamProvider.provideTeamMemberIDs { list in
            list.forEach {
                teamProvider.provideMemberInformationForID(id: $0) { developer in
                    guard let developer else { return }

                    developers.append(developer)
                }
            }
        }
    }
}

extension DevelopersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        developers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let developer = developers[indexPath.row]
        let cell: DevelopersTableViewCell = tableView.dequeueCell(indexPath: indexPath)
        cell.viewConfig = .init(
            name: developer.name,
            address: developer.address,
            codingLevel: developer.codingLevel,
            image: UIImage(systemName: "person.2")!
        )

        return cell
    }
}

extension DevelopersViewController: TeamDataUpdaterDelegate {

    func teamListShouldBeRefreshed() {
        tableView.reloadData()
    }

    func informationForMemberWithIDhasChanged(memberID: String) {
        print("informationForMemberWithIDhasChanged")
        teamProvider.provideMemberInformationForID(id: memberID) { developer in
            print(developer?.photoURL)
        }
    }
}
