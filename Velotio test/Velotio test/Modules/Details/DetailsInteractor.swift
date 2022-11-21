//
//  DetailsInteractor.swift
//  Velotio test
//
//  Created by Rahul Patil on 21/11/22.
//

import Foundation

class DetailsInteractor: DetailsInteractorInput {
    weak var output: DetailsInteractorOutput?
    let network: NetworkServices
    
    init(network: NetworkServices = Network()) {
        self.network = network
    }
    
    func fetchData(id: Int) {
        let timeStamp = "\(Date().timeStamp)"
        let key = (timeStamp+APIConstants.APIKey+APIConstants.PublicKey).hashString
        let endPoint = APIServices.characterDetails(id: id, hashKey: key, timeStamp: timeStamp)
        network.request(endPoint, objectType: BaseResponse.self) { [weak self]  (result: Result<BaseResponse, APIFailure>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.output?.update(items: response)

            case let .failure(error):
                debugPrint(error)
            }
        }
    }
}
