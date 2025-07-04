//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 3.07.2025.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
      static let identifier: String = "RMFooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .label
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(spinner)
        setupUI()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
