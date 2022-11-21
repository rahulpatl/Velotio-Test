//
//  Velotio_testTests.swift
//  Velotio testTests
//
//  Created by Rahul Patil on 17/11/22.
//

import XCTest
@testable import Velotio_test


final class Velotio_testTests: XCTestCase {
    var viewModel = CharactersViewModel()

    func testExample() throws {
        var list = [CharacterDetailsStorage]()
        let context = CoreDataUtils.shared.getContext()
        for i in 1...5 {
            let obj = CharacterDetailsStorage(context: context!)
            obj.name = "\(i)"
            obj.id = Int64(i)
            obj.imageURL = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/53176aa9df48d\(i).jpg"
            list.append(obj)
        }
        viewModel.update(list: list)
        let obj3 = viewModel.characterAt(index: 3)
        XCTAssertNotNil(obj3)
        XCTAssertEqual(obj3!.id, 4)
        XCTAssertFalse(obj3!.isBookmarked)
        XCTAssertEqual(obj3!.imageURL, "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/53176aa9df48d4.jpg")
    }

    func testPerformanceExample() throws {
        viewModel.update(list: [])
    }

}
