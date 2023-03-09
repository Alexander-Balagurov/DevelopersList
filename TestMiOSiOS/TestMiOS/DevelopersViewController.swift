//
//  DevelopersViewController.swift
//  TestMiOS
//
//  Created by Alexander Balagurov on 04.03.2023.
//  Copyright © 2023 Adina Porea. All rights reserved.
//

import UIKit

private extension String {
    static let navigationTitle = "Developers"
}

final class DevelopersViewController: UIViewController {

    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    private let modelController: DevelopersModelController

    init(modelController: DevelopersModelController) {
        self.modelController = modelController

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension DevelopersViewController {

    func setup() {
        title = .navigationTitle
        view.backgroundColor = .white
        setupTableView()
        setupModelController()
    }

    func setupTableView() {
        tableView.layout(in: view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(DevelopersTableViewCell.self)
    }

    func setupModelController() {
        modelController.onListUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        modelController.onMemberInfoUpdate = { [weak self] indexPath in
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension DevelopersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelController.developers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let developer = modelController.developers[indexPath.row]
        let cell: DevelopersTableViewCell = tableView.dequeueCell(indexPath: indexPath)
        let imageURL = URL(string: developer.photoURL ?? "")
        cell.viewConfiguration = .init(
            name: developer.name,
            address: developer.address,
            codingLevel: developer.codingLevel,
            imageURL: imageURL
        )
        cell.encryptionKey = { developer.encryptionKey }

        return cell
    }
}
