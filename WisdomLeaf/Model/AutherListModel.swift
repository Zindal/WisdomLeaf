//
//  AutherListModel.swift
//  WisdomLeaf
//
//  Created by Zindal on 02/05/23.
//

import Foundation

enum RequestResult<T> {
    case success(object: T)
    case failure(error: String)
}

typealias AutherListModel = [AutherInfoViewModel]

class AutherInfoViewModel: Decodable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
    
    required public init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        url = try container.decode(String.self, forKey: .url)
        downloadURL = try container.decode(String.self, forKey: .downloadURL)
    }

}
