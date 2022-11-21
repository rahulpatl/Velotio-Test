//
//  CharactersRouter.swift
//  Velotio test
//
//  Created by Rahul Patil on 19/11/22.
//

import UIKit

class CharactersRouter: CharactersRouterInput {
    var view: UIViewController?
    
    func showCharacter(id: Int) {
        DispatchQueue.main.async {
            let vc = DetailsBuilder().get(character: id)
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
