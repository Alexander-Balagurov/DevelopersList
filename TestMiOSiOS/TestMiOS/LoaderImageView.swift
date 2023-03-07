//
//  LoaderImageView.swift
//  TestMiOS
//
//  Created by Alexander Balagurov on 07.03.2023.
//  Copyright © 2023 Adina Porea. All rights reserved.
//

import UIKit

private extension CGFloat {
    static let indicatorSize: Self = 24
}

final class LoaderImageView: UIView {

    private let placeholderView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    let imageView = UIImageView()
    var imageURL: URL?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        placeholderView.layer.cornerRadius = frame.height / 2
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }
}

private extension LoaderImageView {

    func setup() {
        setupImageView()
        setupPlaceholderView()
    }

    func setupImageView() {
        imageView.layout(in: self)
        Task {
            guard let imageURL else { return }
            
            await imageView.load(from: imageURL)
            updateVisibility()
        }
    }

    func setupPlaceholderView() {
        placeholderView.layout(in: self)
        placeholderView.backgroundColor = .yellow
        activityIndicator.layout(in: placeholderView) {
            $0.centerX == placeholderView.centerXAnchor
            $0.centerY == placeholderView.centerYAnchor
            $0.width == .indicatorSize
            $0.height == $0.width
        }
        activityIndicator.color = .black
        startAnimating()
    }

    func updateVisibility() {
        placeholderView.isHidden = imageView.image != nil
    }
}
