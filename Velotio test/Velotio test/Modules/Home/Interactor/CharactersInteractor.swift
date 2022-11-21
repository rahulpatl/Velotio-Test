//
//  CharactersInteractor.swift
//  Velotio test
//
//  Created by Rahul Patil on 19/11/22.
//

import Foundation
import CryptoKit

class CharactersInteracter: CharactersInteractorInput {
    let network: NetworkServices
    weak var output: CharactersInteractorOutput?
    
    init(network: NetworkServices = Network()) {
        self.network = network
    }
    
    func fetchCharacters(name: String) {
        let timeStamp = "\(Date().timeStamp)"
        let key = (timeStamp+APIConstants.APIKey+APIConstants.PublicKey).hashString
        let endPoint = APIServices.getCharacter(startsWith: name, hashKey: key, ts: timeStamp)
        network.request(endPoint, objectType: BaseResponse.self) { [weak self]  (result: Result<BaseResponse, APIFailure>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.fetchDBData(text: name)

            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
    func getCharacterBy(id: Int) -> CharacterDetailsStorage? {
        if let character = CoreDataUtils.shared.getData(for: CharacterDetailsStorage.self, id: id) {
            return character
        }
        return nil
    }
    
    func update(character: CharacterDetailsStorage) {
        CoreDataUtils.shared.save(data: character)
    }
    
    private func fetchDBData(text: String) {
        if !text.isEmpty, let list = CoreDataUtils.shared.get(for: CharacterDetailsStorage.self, name: text) {
            output?.update(data: list)
        } else if let list = CoreDataUtils.shared.get(data: CharacterDetailsStorage.self) {
            output?.update(data: list)
        }
    }
}
