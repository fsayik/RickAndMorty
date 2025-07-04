//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 2.07.2025.
//

import Foundation
import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject{
    func didLoadInıtialCharacters()
    func didLoadMoreCharacters(with indexPath : [IndexPath])
    func didSelectChacreter(_ character: RMCharacter)
}

final class RMCharacterListViewViewModel : NSObject{
    
    public weak var delegate : RMCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters : Bool = false
    
    private var characters : [RMCharacter] = [] {
        didSet {
            for character in characters{
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name,
                                                                       characterStatus: character.status,
                                                                       characterImageURL: URL(string: character.image)
                )
                if !cellViewModel.contains(viewModel){
                    cellViewModel.append(viewModel)
                }
                
            }
        }
    }
    
    private var cellViewModel: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    
    
    public func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests,expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseData):
                let resultData = responseData.results
                let info = responseData.info
                self?.characters = resultData
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInıtialCharacters()
                }
            case .failure(let error):
                print(error)
            }
        }
         
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        print("add more characters")
        isLoadingMoreCharacters = true
        guard let requestURL = RMRequest(url:url) else {
            print("failed create new character request")
            isLoadingMoreCharacters = false
            return
        }
        
        RMService.shared.execute(requestURL, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
                switch result {
                case .success(let responseData):
                    let moreResult = responseData.results
                    let info = responseData.info
                    strongSelf.apiInfo = info
                    
                    let origanalCount = strongSelf.characters.count
                    let newCount = moreResult.count
                    let total = origanalCount + newCount
                    let startingIndex = total - newCount
                    let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap {
                        return IndexPath(item: $0, section: 0) }
                    
                    strongSelf.characters.append(contentsOf: moreResult)
                    
                    
                    DispatchQueue.main.async {
                        strongSelf.delegate?.didLoadMoreCharacters(
                            with: indexPathsToAdd
                        )
                        strongSelf.isLoadingMoreCharacters = false
                    }
                case .failure(let error):
                        self?.isLoadingMoreCharacters = false
                        print(error)
            }
        }
        
        
    }
    
}

extension RMCharacterListViewViewModel :UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath)
        as? RMCharacterCollectionViewCell else {
            fatalError("Unsported Cell")
        }
        cell.configure(with: cellViewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier, for: indexPath) as? RMFooterLoadingCollectionReusableView
        else {
            fatalError("Unsupported Supplementary View")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30) / 2
        return CGSize(width: width,
                      height: width*1.5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectChacreter(character)
    }
    
    
}

extension RMCharacterListViewViewModel : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator ,
        !isLoadingMoreCharacters,
        !cellViewModel.isEmpty,
        let nextUrlString = apiInfo?.next,
        let nextUrl = URL(string: nextUrlString) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContebtHeight = scrollView.contentSize.height
            let scrolViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContebtHeight - scrolViewFixedHeight - 120){
                self?.fetchAdditionalCharacters(url: nextUrl)
            }
            t.invalidate()
        }
        
    }
}
