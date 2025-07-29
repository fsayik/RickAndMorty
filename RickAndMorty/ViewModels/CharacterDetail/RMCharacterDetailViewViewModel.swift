//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 3.07.2025.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    public var episodes: [String]{
        character.episode
    }
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModel: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModel: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    public var sections: [SectionType] = []
    
    init (character: RMCharacter){
        self.character = character
        setUpSections()
    }
    
    private func setUpSections(){
        sections = [
            .photo(viewModel: .init(photoURL: URL(string: character.image))),
            .information(viewModel: [
                .init(type: .status, value: character.status.text),
                .init(type: .gender, value: character.gender.rawValue),
                .init(type: .type, value: character.type),
                .init(type: .species, value: character.species),
                .init(type: .origin, value: character.origin.name),
                .init(type: .location, value: character.location.name),
                .init(type: .created, value: character.created),
                .init(type: .episodeCount, value: "\(character.episode.count)"),
            ]),
            .episodes(viewModel: character.episode.compactMap ( {
                return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
            }))
        ]
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var name: String {
        return character.name.uppercased()
    }
    
   // MARK : - Layout
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5))
        ,subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
    }
    public func createInformationSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(150))
        ,subitems: [item , item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
    }
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(150))
        ,subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
}
