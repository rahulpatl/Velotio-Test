//
//  DetailsPresenter.swift
//  Velotio test
//
//  Created by Rahul Patil on 21/11/22.
//

import Foundation
class DetailsPresenter: DetailsViewOutput, DetailsInteractorOutput {
    weak var view: DetailsViewInput?
    var interactor: DetailsInteractorInput?
    var router: DetailsRouter?
    var characterId = 0
    
    func fetchData() {
        interactor?.fetchData(id: characterId)
    }
    
    func update(items: BaseResponse) {
        if let result = items.data?.results?.first, let comics = result.comics?.items {
            DispatchQueue.main.async {
                self.view?.update(comics: comics, details: result)
            }
        }
    }
}
