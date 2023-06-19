//
//  NetworkingManager.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError, Error {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "Bad response from the URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured."
            }
        }
    }
    
    static func downloadDataWith(endPoint: EndPoint, httpMethod: HTTPMethod, body: [String:Any]? = nil, queryString: String = "") -> AnyPublisher<Data, Error> {
        
        print("URL: \(endPoint.url)")
        var request = URLRequest(url: endPoint.url)
        request.httpMethod = httpMethod.value
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = UserObject().getObject(forKey: UserObject.Constants.token) as? String {
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body,
           let httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed) {
            request.httpBody = httpBody
        }
        
        print("URL: \(body)")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: endPoint.url) })
            .receive(on: DispatchQueue.main)
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

extension URLSession {
    func dataTask(with request: MultipartFormDataRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask {
        return dataTask(with: request.asURLRequest(), completionHandler: completionHandler)
    }
}

extension NetworkingManager {
    
    enum HTTPMethod: String {
        case get, post, put, delete
        
        var value: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .delete:
                return "DELETE"
            }
        }
    }
}
