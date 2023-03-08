//
//  DevelopersTableViewCell.swift
//  TestMiOS
//
//  Created by Alexander Balagurov on 07.03.2023.
//  Copyright © 2023 Adina Porea. All rights reserved.
//

import UIKit

private extension CGFloat {
    static let imageViewWidthMultiplier: Self = 0.25
    static let codingLevelLabelMinimumScaleFactor: Self = 0.7
}

private extension String {
    static let encryptionKeyButtonTitle = "Show encryption key"
}

final class DevelopersTableViewCell: UITableViewCell {

    private let containerView = UIView()
    private let developerImageView = LoaderImageView()
    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let codingLevelLabel = UILabel()
    private let encryprionKeyButton = UIButton(type: .system)

    var viewConfig: ViewConfig? {
        didSet {
            viewConfigDidChange()
        }
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = ""
        addressLabel.text = ""
        codingLevelLabel.text = ""
        developerImageView.startAnimating()
        developerImageView.imageURL = nil
    }
}

// MARK: - Types

extension DevelopersTableViewCell {

    struct ViewConfig {
        let name: String
        let address: String
        let codingLevel: String
        let imageURL: URL?
    }
}

private extension DevelopersTableViewCell {

    func setup() {
        containerView.layout(in: contentView)
        setupImageView()
        setupStackView()
        setupLabels()
        setupEncryptionKeyButton()
    }

    func setupImageView() {
        developerImageView.layout(in: containerView) {
            $0.leading == containerView.leadingAnchor + UIDimension.layoutMargin2x
            $0.top == containerView.topAnchor + UIDimension.layoutMargin2x
            $0.width *= (containerView.widthAnchor, .imageViewWidthMultiplier)
            $0.height == $0.width
        }
    }

    func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = UIDimension.layoutMargin
        stackView.layout(in: containerView) {
            $0.leading == developerImageView.trailingAnchor + UIDimension.layoutMargin2x
            $0.trailing == containerView.trailingAnchor - UIDimension.layoutMargin2x
            $0.top == containerView.topAnchor + UIDimension.layoutMargin2x
        }
        [nameLabel, addressLabel, codingLevelLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }

    func setupLabels() {
        [nameLabel, addressLabel, codingLevelLabel].forEach {
            $0.font = .systemFont(ofSize: 14)
        }
        codingLevelLabel.numberOfLines = 0
        codingLevelLabel.adjustsFontSizeToFitWidth = true
        codingLevelLabel.minimumScaleFactor = .codingLevelLabelMinimumScaleFactor
    }

    func setupEncryptionKeyButton() {
        encryprionKeyButton.layout(in: containerView) {
            $0.leading == containerView.leadingAnchor + UIDimension.layoutMargin2x
            $0.trailing == containerView.trailingAnchor - UIDimension.layoutMargin2x
            $0.top == developerImageView.bottomAnchor + UIDimension.layoutMargin2x
            $0.bottom == containerView.bottomAnchor - UIDimension.layoutMargin
        }
        encryprionKeyButton.setTitle(.encryptionKeyButtonTitle, for: .normal)
    }

    func viewConfigDidChange() {
        guard let viewConfig else { return }

        nameLabel.text = viewConfig.name
        addressLabel.text = viewConfig.address
        codingLevelLabel.text = viewConfig.codingLevel
        developerImageView.imageURL = viewConfig.imageURL
    }
}
