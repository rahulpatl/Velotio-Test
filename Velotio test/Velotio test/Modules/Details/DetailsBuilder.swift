//
//  DetailsBuilder.swift
//  Velotio test
//
//  Created by Rahul Patil on 21/11/22.
//

import Foundation
class DetailsBuilder {
    func get(character id: Int) -> DetailsVC {
        let vc = DetailsVC()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        let interactor = DetailsInteractor()
        
        vc.output = presenter
        presenter.view = vc
        presenter.characterId = id
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        return vc
    }
}
