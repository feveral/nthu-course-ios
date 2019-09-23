//
//  APIRequest.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/12.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import PromiseKit

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

class APIRequest {
    
    var url: URL
    var urlRequest: URLRequest
    var headers: [String:String] = [:]
    var endpoint: String
    
    init(_ endpoint: String) {
        self.endpoint = endpoint
        self.url = URL(string: endpoint)!
        self.urlRequest = URLRequest(url: url)
    }
    
    func addHeader(key: String, value: String) {
        self.urlRequest.addValue(key, forHTTPHeaderField: value)
        self.headers[key] = value
    }
    
    func get() -> Promise<JSON> {
        return Promise<JSON> { seal in
            Alamofire.request(endpoint).responseData { response in
                if response.result.isSuccess {
                    do {
                        let jsonData = ServiceUtils.removeParenthesesIfExist(response.data!)
                        seal.fulfill(try JSON(data: jsonData))
                    } catch {
                        seal.reject(error)
                    }
                } else {
                    seal.reject(response.result.error!)
                }
            }
        }
    }
    
    func getJsonAndHeader() -> Promise<(JSON, Header)> {
        return Promise<(JSON, Header)> { seal in
            Alamofire.request(endpoint).responseData { response in
                if response.result.isSuccess {
                    do {
                        let jsonData = ServiceUtils.removeParenthesesIfExist(response.data!)
                        let json = try JSON(data: jsonData)
                        let header = Header(response.response!.allHeaderFields)
                        seal.fulfill((json, header))
                    } catch {
                        seal.reject(error)
                    }
                } else {
                    seal.reject(response.result.error!)
                }
            }
        }
    }
    
    func getHtml() -> Promise<String> {
        return Promise<String> { seal in
            Alamofire.request(endpoint).responseData { response in
                if response.result.isSuccess {
                    let html = String(data: response.data!, encoding: String.Encoding.utf8)!
                    seal.fulfill(html)
                } else {
                    seal.reject(response.result.error!)
                }
            }
        }
    }
    
//    func get(completion: @escaping (Result<JSON, APIError>) -> Void) {
//        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
//                let jsonData = data else {
//                    completion(.failure(.responseProblem))
//                    return
//            }
//            do {
//                let json = try JSON(data: jsonData)
//                completion(.success(json))
//            } catch {
//                completion(.failure(.decodingProblem))
//            }
//        }
//        task.resume()
//    }
//
//    func getWithHeaders(completion: @escaping (Result<(JSON, Header), APIError>) -> Void) {
//        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
//                var jsonData = data else {
//                    completion(.failure(.responseProblem))
//                    return
//            }
//            do {
//                // Only for ilms login
//                jsonData = ServiceUtils.removeParenthesesIfExist(jsonData)
//                let json = try JSON(data: jsonData)
//                let header = Header(httpResponse.allHeaderFields)
//                completion(.success((json, header)))
//            } catch {
//                print(error)
//                completion(.failure(.decodingProblem))
//            }
//        }
//        task.resume()
//    }
//
//    func getHTML(completion:  @escaping (Result<String, APIError>) -> Void) {
//        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
//                let jsonData = data else {
//                    completion(.failure(.responseProblem))
//                    return
//            }
//            completion(.success(String(data: jsonData, encoding: String.Encoding.utf8)!))
//        }
//        task.resume()
//    }
//
//    func post(toSend: JSON, completion: @escaping (Result<JSON, APIError>) -> Void) {
//
//        do {
//            var urlRequest = URLRequest(url: url)
//            urlRequest.httpMethod = "POST"
//            urlRequest.addValue("application/json", forHTTPHeaderField: "Content/Type")
//            urlRequest.httpBody = try toSend.rawData()
//
//            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
//                    let jsonData = data else {
//                        completion(.failure(.responseProblem))
//                        return
//                }
//                do {
//                    let json = try JSON(data: jsonData)
//                    completion(.success(json))
//                } catch {
//                    completion(.failure(.decodingProblem))
//                }
//            }
//            task.resume()
//        }
//        catch {
//            completion(.failure(.encodingProblem))
//        }
//    }
}