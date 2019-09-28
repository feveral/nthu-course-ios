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

class APIRequest {
    
    var headers: [String:String] = [:]
    var endpoint: String
    
    init(_ endpoint: String) {
        self.endpoint = endpoint
    }
    
    func addHeader(key: String, value: String) {
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
            Alamofire.request(endpoint, headers: headers).responseData { response in
                if response.result.isSuccess {
                    let html = String(data: response.data!, encoding: String.Encoding.utf8)!
                    seal.fulfill(html)
                } else {
                    seal.reject(response.result.error!)
                }
            }
        }
    }
}
