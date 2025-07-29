//
//  RMEpisodeDetailVC.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 28.07.2025.
//

import UIKit

final class RMEpisodeDetailVC: UIViewController {
    private let url : URL?
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "episode"
    }
   
}
