//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 2.07.2025.
//

import Foundation
import UIKit

final class RMCharacterListViewViewModel : NSObject{
    
    func fetchCharacters() {
        let request = RMRequest(endpoint : .character)
        //print(request.url)
        
        RMService.shared.execute(request,expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let data):
                print(data.results.count)
            case .failure(let error):
                print(error)
            }
        }
         
    }
    
}

extension RMCharacterListViewViewModel :UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30) / 2
        return CGSize(width: width,
                      height: width*1.5)
        
    }
    
    
}
