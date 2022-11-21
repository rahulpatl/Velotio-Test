//
//  CharactersViewModel.swift
//  Velotio test
//
//  Created by Rahul Patil on 20/11/22.
//

import Foundation
final class CharactersViewModel {
    private var list: [CharacterDetailsStorage] = []
    private var searchString = ""
    var srarchText: String {
        return searchString
    }
    var charactersCount: Int {
        return list.count
    }
    
    func update(list: [CharacterDetailsStorage]) {
        self.list = list
    }
    
    func characterAt(index: Int) -> CharacterDetailsStorage? {
        if list.count > index, index > -1 {
            return list[index]
        }
        return nil
    }
    
    func updateSearch(text: String) {
        self.searchString = text
    }
}
