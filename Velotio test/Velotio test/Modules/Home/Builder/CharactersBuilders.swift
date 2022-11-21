//
//  CharactersBuilders.swift
//  Velotio test
//
//  Created by Rahul Patil on 19/11/22.
//

import Foundation
class CharactersBuilder: CharactersBuilderProtocol {
    func getCharacter() -> CharactersVC {
        let vc = CharactersVC()
        let viewModel = CharactersViewModel()
        let presenter = CharacterPresenter(viewModel: viewModel)
        let interactor = CharactersInteracter()
        let router = CharactersRouter()
        
        vc.output = presenter
        vc.viewModel = viewModel
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.view = vc
        
        return vc
    }
}
