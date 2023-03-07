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
    private let modelController = DevelopersModelController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension DevelopersViewController {

    func setup() {
        title = .navigationTitle
        view.backgroundColor = .white
        modelController.setTeamUIDelegate(self)
        setupTableView()
    }

    func setupTableView() {
        tableView.layout(in: view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(DevelopersTableViewCell.self)
    }
}

extension DevelopersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelController.developers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let developer = modelController.developers[indexPath.row]
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

    }
}
