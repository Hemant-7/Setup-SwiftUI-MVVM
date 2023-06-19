//
//  MultipartFormDataRequest.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import Foundation

struct MultipartFormDataRequest {
    private let boundary: String = UUID().uuidString
    private var httpBody = NSMutableData()
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func addDataField(named name: String,
                      data: Data,
                      mimeType: String) {
        httpBody.append(dataFormField(named: name, data: data, mimeType: mimeType))
    }

    private func dataFormField(named name: String,
                               data: Data,
                               mimeType: String) -> Data {
        let fieldData = NSMutableData()
        
        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"\r\n")
        fieldData.append("Content-Type: \(mimeType)\r\n")
        fieldData.append("\r\n")
        fieldData.append(data)
        fieldData.append("\r\n")
        
        return fieldData as Data
    }
    
    func asURLRequest() -> URLRequest {

        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        if let token = UserObject().getObject(forKey: UserObject.Constants.token) as? String {
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        }
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        httpBody.append("--\(boundary)--".data(using: .utf8)!)
        request.httpBody = httpBody as Data
        return request
    }
}

extension NSMutableData {
  func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
