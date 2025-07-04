//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 3.07.2025.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    init (character: RMCharacter){
        self.character = character
    }
    
    public var name: String {
        return character.name.uppercased()
    }
}
