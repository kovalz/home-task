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
    
    // MARK: - Public properties
    
    let isLoading = Dynamic(false)

    // MARK: - Public methods
    
    func loadTopLinks(paging: Paging? = nil,
                      success: @escaping (_ links: LinksList) -> (),
                      failure: @escaping (_ error: Error) -> ())
    {
        guard isLoading.value == false else {
            return
        }
        
        var parameters = [RequestParameter]()
        paging?.limit.flatMap { parameters.append(.limit($0)) }
        paging?.after.flatMap { parameters.append(.after(fullName: $0)) }

        guard let url = EndPoints.topLinks.createURL(with: parameters) else {
            DispatchQueue.main.async {
                failure(ErrorKind.unableToCreateURL)
            }
            return
        }
        
        isLoading.value = true
        let task = URLSession.shared.dataTask(with: url) { [weak self] (jsonData, response, error) in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading.value = false
                    failure(error)
                }
                return
            }
            
            if let jsonData = jsonData {
                do {
                    let links = try strongSelf.decodeLinks(from: jsonData)
                    DispatchQueue.main.async { [weak self] in
                        self?.isLoading.value = false
                        success(links)
                    }
                } catch let error {
                    DispatchQueue.main.async { [weak self] in
                        self?.isLoading.value = false
                        failure(error)
                    }
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading.value = false
                    failure(ErrorKind.emptyResponseData)
                }
            }
        }
        
        task.resume()
    }
        
    // MARK: - Private methods
    
    private func decodeLinks(from jsonData: Data) throws -> LinksList {
        let serverLinks = try JSONDecoder().decode(RedditLinksServerResponse.self, from: jsonData)
        let paging = LinksList.Paging(after: serverLinks.data.after)
        let links: [Link] = serverLinks.data.children.map {
            
            var thumbnailURLString = $0.data.thumbnail
            if thumbnailURLString?.hasPrefix("https") == false {
                thumbnailURLString = nil
            }
            
            let sourceImageURLString = $0.data.preview?.images.first?.source.url

            return Link(title: $0.data.title,
                        author: $0.data.author,
                        creationDate: Date(timeIntervalSince1970: $0.data.created_utc),
                        commentsCount: $0.data.num_comments,
                        thumbnailURL: thumbnailURLString.flatMap { URL(string: $0) },
                        sourceImageURL: sourceImageURLString.flatMap { URL(string: $0) })
        }
        
        return LinksList(links: links, paging: paging)
    }
    
}

