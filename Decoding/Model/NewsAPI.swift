//
//  NewsAPI.swift
//  Decoding
//
//  Created by Mr_Xu on 2017/12/15.
//  Copyright © 2017年 Mr_xc. All rights reserved.
//

import Foundation


class NewsAPI: NSObject {
    static let server = NewsAPI()
    
    @objc dynamic private(set) var sources: [SourceModel] = []
    @objc dynamic private(set) var articles: [ArticleModel] = []
    
    private struct Respone: Codable {
        var sources: [SourceModel]?
        var articles: [ArticleModel]?
    }
    
    func fetchSourse() {
        if let data = API.sources.fetchLocationData() {
            do {
                if let str = String.init(data: data, encoding: String.Encoding.utf8) {
                    print(str)
                }
                guard let sources = try JSONDecoder().decode(Respone.self, from: data).sources else { return }
                self.sources = sources
            }catch DecodingError.keyNotFound(let key, let context){
                print("MissKey:\(key)")
                print("Debug description:\(context)")
            }catch DecodingError.valueNotFound(let value, let context) {
                print("MissValue:\(value)")
                print("Debug description:\(context)")
            }catch DecodingError.typeMismatch(let type, let context) {
                print("MissType:\(type)")
                print("Debug description:\(context)")
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    func fetchArticles(for sourse: SourceModel) {
        if let data = API.articles(sourse).fetchLocationData() {
            if let str = String.init(data: data, encoding: String.Encoding.utf8) {
                print(str)
            }
            do {
                guard let arit = try JSONDecoder().decode(Respone.self, from: data).articles else {
                    return
                }
                articles = arit
            }catch DecodingError.keyNotFound(let key, let context){
                print("MissKey:\(key)")
                print("Debug description:\(context)")
            }catch DecodingError.valueNotFound(let value, let context) {
                print("MissValue:\(value)")
                print("Debug description:\(context)")
            }catch DecodingError.typeMismatch(let type, let context) {
                print("MissType:\(type)")
                print("Debug description:\(context)")
            }catch {
                print(error.localizedDescription)
            }
            
        }
    }
}

enum API {
    private static let basePath = "https://newsapi.org/v1"
    private static let key = "dbe66ccbe2c84116b6ccf25d598d9f49"
    
    case sources
    case articles(SourceModel)
    
    private func path() -> URL {
        switch self {
        case .sources:
            return URL(string: "\(API.basePath)/sources")!
        case .articles(let sourceModel):
            return URL(string: "\(API.basePath)/articles?source=\(sourceModel.id)&apiKey=\(API.key)")!
        }
    }
    //MARK: -如果可以科学上网用这个方法
    func fetch(completion:@escaping (Data) -> ()) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: path()) { (data, response, error) in
            guard let data = data, error == nil else { return }
            completion(data)
        }
        task.resume()
    }
    
    //MARK: -如果不可以科学上网用这个方法
    func fetchLocationData() -> Data? {
        switch self {
        case .sources:
            guard let path = Bundle.main.path(forResource: "sour.json", ofType: nil)
                else { return nil}
            let url = URL.init(fileURLWithPath: path)
            guard let data = try? Data.init(contentsOf: url) else { return nil}
            return data
        case .articles(_):
            guard let path = Bundle.main.path(forResource: "articles.json", ofType: nil)
                else { return nil}
            let url = URL.init(fileURLWithPath: path)
            guard let data = try? Data.init(contentsOf: url) else { return nil}
            return data
        }
        
        
    }
    
}




