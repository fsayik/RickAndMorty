//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 4.07.2025.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterPhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func setupUI () {
        addSubviews(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel){
        viewModel.fetchImage { [ weak self ] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: image)
                }
            case .failure(let error):
                print("Error fetching image: \(error)")
            }
        }
    }
}
