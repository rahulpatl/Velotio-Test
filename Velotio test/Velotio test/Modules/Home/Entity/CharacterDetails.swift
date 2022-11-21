//
//  CharacterDetails.swift
//  Velotio test
//
//  Created by Rahul Patil on 20/11/22.
//

import UIKit

struct CharacterDetails : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let thumbnail : Thumbnail?
    let comics : Comics?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case thumbnail = "thumbnail"
        case comics = "comics"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        thumbnail = try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        comics = try values.decodeIfPresent(Comics.self, forKey: .comics)
        DispatchQueue.main.async { [id, name, thumbnail] in
            if let _id = id,
               let charData = CoreDataUtils.shared.getData(for: CharacterDetailsStorage.self, id: _id) {
                charData.id = Int64(_id)
                charData.name = name
                charData.imageURL = thumbnail?.getURL().string
                CoreDataUtils.shared.save(data: charData)
            } else if let _id = id,
                        let context = CoreDataUtils.shared.getContext()  {
                let model = CharacterDetailsStorage(context: context)
                model.id = Int64(_id)
                model.name = name
                model.imageURL = thumbnail?.getURL().string
                CoreDataUtils.shared.save(data: model)
            }
        }
    }
}

struct Thumbnail : Codable {
    let path : String?
    let imgExtension : String?
    var image: UIImage?

    enum CodingKeys: String, CodingKey {
        case path = "path"
        case imgExtension = "extension"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        imgExtension = try values.decodeIfPresent(String.self, forKey: .imgExtension)
    }
    
    func getURL() -> (string: String?, path: URL?) {
        guard let path = path,
                let imageExtension = imgExtension,
                let url = URL(string:path + "." + imageExtension) else {
            return (nil, nil)
        }
        
        return ((path + "." + imageExtension) ,url)
    }
}

