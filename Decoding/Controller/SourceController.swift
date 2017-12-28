//
//  ViewController.swift
//  Decoding
//
//  Created by Mr_Xu on 2017/12/15.
//  Copyright © 2017年 Mr_xc. All rights reserved.
//

import UIKit

class SourceController: UITableViewController {

    private var sourceToken: NSKeyValueObservation?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sourceToken = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加观察者，记录token
        sourceToken = NewsAPI.server.observe(\.sources, changeHandler: { (_, _) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        //请求source数据
        NewsAPI.server.fetchSourse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "PushArticlesSegue",
            let destination = segue.destination as? ArticleController,
            let indexPath = tableView.indexPathForSelectedRow
            else { return }
            destination.sourse = NewsAPI.server.sources[indexPath.row]
    }
}

extension SourceController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsAPI.server.sources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as! SourceCell
        cell.sourceModel = NewsAPI.server.sources[indexPath.row]
        return cell
    }
    
}




