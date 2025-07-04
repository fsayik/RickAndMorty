//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 2.07.2025.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel : Hashable , Equatable{
 

    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let  characterImageURL: URL?
    
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
    
    init(
        characterName: String,
        characterStatus: RMCharacterStatus,
        characterImageURL: URL?
    ){
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    public var characterStatusText: String {
        "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageURL = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(from: imageURL, completion: completion)
    }
    
}
