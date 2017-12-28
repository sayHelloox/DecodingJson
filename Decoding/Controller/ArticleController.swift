//
//  ArticleController.swift
//  Decoding
//
//  Created by Mr_Xu on 2017/12/15.
//  Copyright © 2017年 Mr_xc. All rights reserved.
//

import UIKit

class ArticleController: UITableViewController {
    var sourse: SourceModel?
    private var token: NSKeyValueObservation?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        token = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let model = sourse else { return }
        token = NewsAPI.server.observe(\.articles, changeHandler: { (_, _) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        NewsAPI.server.fetchArticles(for: model)
    }
}


extension ArticleController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NewsAPI.server.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.model = NewsAPI.server.articles[indexPath.row]
        return cell
    }
}
