//
//  RMCharacterDetailVC.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 3.07.2025.
//

import UIKit

final class RMCharacterDetailVC: UIViewController {
    
    
    // MARK: - Variable
    let viewModel: RMCharacterDetailViewViewModel
    
    // MARK: - UI Components
    private let detailView: RMCharacterDetailView
    
    // MARK: - LifeCycle
    init(viewModel: RMCharacterDetailViewViewModel){
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        setupUI()
        
        detailView.collectionView?.dataSource = self
        detailView.collectionView?.delegate = self
    }
    
    @objc private func shareTapped(){
        
    }
    // MARK: - UI Setup
    private func setupUI(){
        view.addSubviews(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }
    
}

// MARK: - CollectionView
extension RMCharacterDetailVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterPhotoCollectionViewCell else {
                    fatalError()
                }
            cell.configure(with: viewModels)
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterInfoCollectionViewCell else {
                    fatalError()
                }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
                    fatalError()
                }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo,.information:
            break
        case .episodes:
            let episodes = self.viewModel.episodes
            let selection = episodes[indexPath.row]
            let vc = RMEpisodeDetailVC(url: URL(string: selection))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
