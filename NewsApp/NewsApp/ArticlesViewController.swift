//
//  ArticlesViewController.swift
//  NewsApp
//
//  Created by Kiryl Rakk on 6/12/22.
//

import UIKit
import SnapKit

class ArticlesViewController: UIViewController {
    
    var articles : [ArticlesCodable] = []
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: self)
        controller.delegate = self
        return controller
    } ()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Articles"
        downloadArticles { articles in
            self.articles = articles!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        setLayers()
    }
    
    
    private func setLayers () {
        self.navigationItem.searchController = searchController
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ReadArticleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ArticlesViewController : UISearchControllerDelegate {
    
}
