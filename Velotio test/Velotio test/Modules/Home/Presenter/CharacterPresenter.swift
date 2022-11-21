//
//  CharacterPresenter.swift
//  Velotio test
//
//  Created by Rahul Patil on 19/11/22.
//

import Foundation
final class CharacterPresenter: CharactersViewOutput, CharactersInteractorOutput {
    weak var view: CharactersViewInput?
    var router: CharactersRouterInput?
    var interactor: CharactersInteractorInput?
    var viewModel: CharactersViewModel
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }
    
    func search(character name: String) {
        interactor?.fetchCharacters(name: name)
    }
    
    func update(data: [CharacterDetailsStorage]) {
        viewModel.update(list: data)
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
    func makeBookmark(character: CharacterDetailsStorage) {
        character.isBookmarked = !character.isBookmarked
        interactor?.update(character: character)
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
}
