//
//  RedditService.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

class RedditService {
    
    enum ErrorKind: Swift.Error {
        case unableToCreateURL
        case emptyResponseData
    }
    
    private enum EndPoints: String {
        case topLinks = "https://reddit.com/top.json"
        
        func createURL(with parameters: [RequestParameter] = [RequestParameter]()) -> URL? {
            var urlString = rawValue

            if parameters.count > 0 {
                let query = parameters.reduce("?") { (result, parameter) -> String in
                    return result + "&" + "\(parameter.rawData.0)" + "=" + "\(parameter.rawData.1)"
                }
                
                if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                    urlString += encodedQuery
                } else {
                    return nil
                }
            }
            
            return URL(string: urlString)
        }
    }
    
    private enum RequestParameter {
        case after(fullName: String)
        case limit(Int)
        
        var rawData: (String, Any) {
            switch self {
            case .after(let fullName):
                return ("after", fullName)
            case .limit(let value):
                return ("limit", value)
            }
        }

    }
    
    // MARK: - Public methods
    
    func loadTopLinks(paging: Paging? = nil,
                      success: @escaping (_ links: LinksList) -> (),
                      failure: @escaping (_ error: Error) -> ())
    {
        var parameters = [RequestParameter]()
        if let paging = paging {
            parameters.append(.after(fullName: paging.after))
            parameters.append(.limit(paging.limit))
        }
        
        guard let url = EndPoints.topLinks.createURL(with: parameters) else {
            DispatchQueue.main.async {
                failure(ErrorKind.unableToCreateURL)
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (jsonData, response, error) in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                failure(error)
                return
            }
            
            if let jsonData = jsonData {
                do {
                    let links = try strongSelf.decodeLinks(from: jsonData)
                    success(links)
                } catch let error {
                    failure(error)
                }
            } else {
                failure(ErrorKind.emptyResponseData)
            }
        }
        
        task.resume()
    }
        
    // MARK: - Private methods
    
    private func decodeLinks(from jsonData: Data) throws -> LinksList {
        let serverLinks = try JSONDecoder().decode(RedditLinksServerResponse.self, from: jsonData)
        let paging = LinksList.Paging(after: serverLinks.data.after)
        let links = serverLinks.data.children.map {
            return Link(title: $0.data.title,
                        author: $0.data.author,
                        created: Date(),
                        commentsCount: $0.data.num_comments,
                        thumbnailURL: $0.data.thumbnail.flatMap { URL(string: $0) } )
        }
        
        return LinksList(links: links, paging: paging)
    }
    
}

