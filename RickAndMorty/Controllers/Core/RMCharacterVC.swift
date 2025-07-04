//
//  RMCharacterVC.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 23.04.2024.
//

import UIKit

class RMCharacterVC: UIViewController , RMCharacterListViewDelegate{
   
    // MARK: - Variable
   
    
    // MARK: - UI Components
    private let listView = RMCharacterListView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Character"
        
        setupUI()
   
    }
    // MARK: - UI Setup
    private func setupUI() {
        listView.delegate = self
        view.addSubview(listView)
        
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
           
        ])
    }
    
    
    
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        //open character detail screen
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailVC(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
