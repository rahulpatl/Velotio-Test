//
//  CharactersProtocols.swift
//  Velotio test
//
//  Created by Rahul Patil on 19/11/22.
//

import Foundation

protocol CharactersViewOutput {
    func search(character name: String)
    func makeBookmark(character: CharacterDetailsStorage)
}

protocol CharactersViewInput: AnyObject {
    func reloadData()
}

protocol CharactersInteractorInput {
    func fetchCharacters(name: String)
    func getCharacterBy(id: Int) -> CharacterDetailsStorage?
    func update(character: CharacterDetailsStorage)
}

protocol CharactersInteractorOutput: AnyObject {
    func update(data: [CharacterDetailsStorage])
}

protocol CharactersRouterInput {
    func showBookmarks()
}

protocol CharactersBuilderProtocol {
    func getCharacter() -> CharactersVC
}

protocol CharacterCellDelegate: AnyObject {
    func addBookmark(model: CharacterDetailsStorage)
}
