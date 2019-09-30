//
//  NetworkLayer.swift
//  TesteiOS
//
//  Created by resource on 29/09/19.
//  Copyright © 2019 leovalentim. All rights reserved.
//

import Foundation

protocol NetworkLayer {
    typealias NetworkResult<T> = Result<T, Error>
    
    func get(_ url: URL, headers: [String : String]?, completion: @escaping (NetworkResult<Data>) -> Void)
    func get<T: Codable>(_ url: URL, model: T.Type, headers: [String : String]?, completion: @escaping (NetworkResult<T>) -> Void)
    
    func post(_ url: URL, params: [String : Any], headers: [String : String]?, completion: @escaping (NetworkResult<Data>) -> Void)
    func post<T: Codable>(_ url: URL, model: T.Type, params: [String : Any], headers: [String : String]?, completion: @escaping (NetworkResult<T>) -> Void)
}
