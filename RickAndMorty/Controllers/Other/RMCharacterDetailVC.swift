//
//  RMCharacterDetailVC.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 3.07.2025.
//

import UIKit

final class RMCharacterDetailVC: UIViewController {
    let viewModel: RMCharacterDetailViewViewModel
    init(viewModel: RMCharacterDetailViewViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.name
    }
}
