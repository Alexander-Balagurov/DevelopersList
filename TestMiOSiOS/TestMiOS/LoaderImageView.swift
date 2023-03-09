//
//  LoaderImageView.swift
//  TestMiOS
//
//  Created by Alexander Balagurov on 07.03.2023.
//  Copyright © 2023 Adina Porea. All rights reserved.
//

import UIKit


final class LoaderImageView: UIView {

    private let placeholderView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let imageView = UIImageView()
    private var updateImageTask: Task<Void, Never>?
    var imageURL: URL? {
        didSet {
            updateImage()
        }
    }

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
    }

    func setupPlaceholderView() {
        placeholderView.layout(in: self)
        placeholderView.backgroundColor = .yellow
        activityIndicator.layout(in: placeholderView) {
            $0.centerX == placeholderView.centerXAnchor
            $0.centerY == placeholderView.centerYAnchor
        }
        activityIndicator.color = .black
        startAnimating()
    }

    func updateImage() {
        updateImageTask?.cancel()
        updateImageTask = Task {
            imageView.image = nil
            guard let imageURL else {
                updateVisibility()
                return
            }

            await imageView.load(from: imageURL)
            updateVisibility()
        }
    }

    func updateVisibility() {
        placeholderView.isHidden = imageView.image != nil
        if imageURL == nil {
            activityIndicator.stopAnimating()
        }
    }
}
