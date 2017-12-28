//
//  ArticleModel.swift
//  Decoding
//
//  Created by Mr_Xu on 2017/12/15.
//  Copyright © 2017年 Mr_xc. All rights reserved.
//

import Foundation

class ArticleModel: NSObject, Codable {
    let author: String?
    let title: String
    let snippet: String
    let sourceURL: URL
    let imageURL: URL
    let published: String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case snippet = "description"
        case sourceURL = "url"
        case imageURL = "urlToImage"
        case published = "publishedAt"
    }
    
    init(author: String, title: String, snippet: String, sourceURL: URL, imageURL: URL, published: String) {
        self.author = author
        self.title = title
        self.snippet = snippet
        self.sourceURL = sourceURL
        self.imageURL = imageURL
        self.published = published
    }
    
    //如果想要对某个字段的数据进行二次处理，则需要通过如下方式进行处理
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tempAuthor = try container.decodeIfPresent(String.self, forKey: .author) ?? "哈哈，没有名字"
        //想要再次处理的数据
        author = "name: " + tempAuthor
        title = try container.decode(String.self, forKey: .title)
        sourceURL = try container.decode(URL.self, forKey: .sourceURL)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
        published = try container.decodeIfPresent(String.self, forKey: .published)
        snippet = try container.decode(String.self, forKey: .snippet)
    }
}
