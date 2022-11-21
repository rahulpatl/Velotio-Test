//
//  DetailsProtocol.swift
//  Velotio test
//
//  Created by Rahul Patil on 21/11/22.
//

import Foundation
protocol DetailsViewOutput {
    func fetchData()
}

protocol DetailsViewInput: AnyObject {
    func update(comics: [Items], details: CharacterDetails)
}

protocol DetailsInteractorInput {
    func fetchData(id: Int)
}

protocol DetailsInteractorOutput: AnyObject {
    func update(items: BaseResponse)
}

protocol DetailsRouterInput {
    
}
