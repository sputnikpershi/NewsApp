//
//  Network Manager.swift
//  NewsApp
//
//  Created by Kiryl Rakk on 6/12/22.
//

import UIKit

//
//{
//"status": "ok",
//"totalResults": 68,
//-"articles": [
//-{
//-"source": {
//"id": null,
//"name": "CNBC"
//},
//"author": "Krystal Hur",
//"title": "The Fed can’t stop raising interest rates due to these 4 factors, Jim Cramer says - CNBC",
//"description": "\"This market's hostage to the Federal Reserve, and the Fed's not going to stop tightening until they see more evidence of real economic pain,\" Jim Cramer said.",
//"url": "https://www.cnbc.com/2022/12/05/cramer-fed-cant-stop-raising-interest-rates-due-to-these-4-factors.html",
//"urlToImage": "https://image.cnbcfm.com/api/v1/image/107109966-NUP_198430_00164r.jpg?v=1670282403&w=1920&h=1080",
//"publishedAt": "2022-12-05T23:20:03Z",
//"content": "CNBC's Jim Cramer on Monday listed four reasons why the Federal Reserve can't stop tightening the economy just yet.\r\n<ol><li>Not enough people are reentering the workforce. That makes it more difficu… [+1589 chars]"
//},

struct Answer: Codable {
    var articles: [ArticlesCodable]
}

struct ArticlesCodable: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

func downloadArticles (completion: (([ArticlesCodable]?) -> ())? ) {
    let url  = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=3a868491a5d349769df8235036470a10")!
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in
        
        if let error {
            print(error.localizedDescription)
            completion?(nil)
        }
        
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        if statusCode != 200 {
            print(error?.localizedDescription)
            completion?(nil)
        }
        
        guard let data = data else {
            print("data error")
            completion?(nil)
            return
        }
        
        do {
            let answer = try JSONDecoder().decode(Answer.self, from: data)
            completion?(answer.articles)
        } catch {
            print(error.localizedDescription)
        }
    }
    task.resume()
}
