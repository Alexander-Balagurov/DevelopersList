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

private extension TimeInterval {
    static let hideDelay: Self = 5
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
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let encryptionKeyLabel = UILabel()

    var encryptionKey: (() -> String)?
    var viewConfiguration: ViewConfiguration? {
        didSet {
            viewConfigurationDidChange()
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
        encryptionKeyLabel.text = ""
        developerImageView.startAnimating()
        developerImageView.imageURL = nil
    }
}

// MARK: - Types

extension DevelopersTableViewCell {

    struct ViewConfiguration {
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
        setupEncryptionKeyLabel()
        setupActivityIndicator()
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
        [nameLabel, addressLabel, codingLevelLabel, encryptionKeyLabel].forEach {
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
        encryprionKeyButton.addTarget(self, action: #selector(encryptionKeyButtonTap), for: .touchUpInside)
    }

    func setupActivityIndicator() {
        activityIndicator.layout(in: containerView) {
            $0.centerX == containerView.centerXAnchor
            $0.bottom == containerView.bottomAnchor - UIDimension.layoutMargin2x
        }
        activityIndicator.color = .black
    }

    func setupEncryptionKeyLabel() {
        encryptionKeyLabel.layout(in: containerView) {
            $0.leading == containerView.leadingAnchor + UIDimension.layoutMargin
            $0.trailing == containerView.trailingAnchor - UIDimension.layoutMargin
            $0.top == developerImageView.bottomAnchor + UIDimension.layoutMargin
            $0.bottom == containerView.bottomAnchor - UIDimension.layoutMargin
        }
        encryptionKeyLabel.isHidden = true
    }

    @objc func encryptionKeyButtonTap() {
        toggleVisibility()
        activityIndicator.startAnimating()

        DispatchQueue.global(qos: .userInteractive).async {
            let key = self.encryptionKey?()

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.encryptionKeyLabel.text = key

                DispatchQueue.main.asyncAfter(deadline: .now() + .hideDelay) {
                    self.toggleVisibility()
                    self.encryptionKeyLabel.text = ""
                }
            }
        }
    }

    func toggleVisibility() {
        encryprionKeyButton.isHidden = !encryprionKeyButton.isHidden
        encryptionKeyLabel.isHidden = !encryptionKeyLabel.isHidden
    }

    func viewConfigurationDidChange() {
        guard let viewConfiguration else { return }

        nameLabel.text = viewConfiguration.name
        addressLabel.text = viewConfiguration.address
        codingLevelLabel.text = viewConfiguration.codingLevel
        developerImageView.imageURL = viewConfiguration.imageURL
    }
}
