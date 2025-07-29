//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 4.07.2025.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel{
    private let photoURL: URL?
    
    
    init(photoURL: URL?){
        self.photoURL = photoURL
    }
    
    public func fetchImage(completion: @escaping (Result <Data, Error>) -> Void){
        guard let photoURL = photoURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(from: photoURL, completion: completion)
   
    }
}
