//
//  NetworkingManager.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import Foundation
import Combine

class NetworkingManager: NSObject {
    
    static let shared = NetworkingManager()
    
    override private init() {}
    
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
    
    func downloadDataWith(endPoint: EndPoint, httpMethod: HTTPMethod, body: [String:Any]? = nil, queryString: String = "") -> AnyPublisher<Data, Error> {
        
        print("Request URL: \(endPoint.url)")
        print("Request Method: \(httpMethod.value)")
        
        if let body = body,
           let httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed),
           let jsonString = String(data: httpBody, encoding: .utf8) {
            print("Request JSON: \(jsonString)")
        }
        
        var request = URLRequest(url: endPoint.url)
        request.httpMethod = httpMethod.value
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = UserObject().getObject(forKey: UserObject.Constants.token) as? String {
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try NetworkingManager.handleURLResponse(output: $0, url: endPoint.url) })
            .receive(on: DispatchQueue.main)
            .retry(3)
            .map { data in
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
                return data
            }
            .eraseToAnyPublisher()
    }
    
    
    func request(request: URLRequest, endPoint: EndPoint) -> AnyPublisher<Data, Error> {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try NetworkingManager.handleURLResponse(output: $0, url: endPoint.url) })
            .receive(on: DispatchQueue.main)
            .retry(3)
            .map { data in
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
                return data
            }
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

extension NetworkingManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("CERTIFICATE TRUSTED BY DEFAULT")
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
