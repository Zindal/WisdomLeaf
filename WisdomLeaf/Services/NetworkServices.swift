//
//  NetworkServices.swift
//  WisdomLeaf
//
//  Created by Zindal on 02/05/23.
//

import Foundation
import Alamofire

class NetworkServices {
    
    static let shared = NetworkServices()

    private let decoder = JSONDecoder()

    typealias Completion<T> = (RequestResult<T>) -> Void
    
    public func getAutherList(page:Int,completion: @escaping Completion<AutherListModel>) {
        
        let requestUrlString = "https://picsum.photos/v2/list?page=\(page)&limit=20"
        
        AF.request(requestUrlString, headers: nil)
            .responseDecodable(of: AutherListModel.self) { response in
                switch response.result {
                case let .success(data):
                    completion(.success(object: data))
                case let .failure(error):
                    completion(.failure(error: error.localizedDescription))
                }
            }
    }
}
