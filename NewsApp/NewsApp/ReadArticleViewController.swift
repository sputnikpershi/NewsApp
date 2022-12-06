//
//  ReadArticleViewController.swift
//  NewsApp
//
//  Created by Kiryl Rakk on 6/12/22.
//

import UIKit
import SnapKit

class ReadArticleViewController: UIViewController {

    private lazy var articleImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.backgroundColor = .green
        return title
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let description = UILabel()
        description.backgroundColor = .orange
        return description
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .gray
        super.viewDidLoad()
        setLayers()
    }
    
    
    private func setLayers() {
        self.view.addSubview(articleImage)
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        
        articleImage.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(self.articleImage.snp.bottom).offset(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
        }
        
    }

}
