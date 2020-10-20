//
//  NewsViewController.swift
//  Covid-19
//
//  Created by Tarokh on 8/24/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import JGProgressHUD

class NewsViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var newsTableView: UITableView!
    
    
    //MARK: - Variables
    var newsManager = NewsManager()
    var hud: JGProgressHUD?
    
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.isHidden = true
        
        hud = JGProgressHUD(style: .dark)
        hud?.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud?.show(in: self.view, animated: true)
        
        newsManager.delegate = self
        newsManager.getNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.title = "Covid-19 News"
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    //MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToURL" {
            let webVC = segue.destination as! WebController
            let indexPath = self.newsTableView.indexPathForSelectedRow
            let urlItem = newsManager.newsItems[indexPath!.row].url
            webVC.url = urlItem
        }
    }

}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsManager.newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsCell
        let item = newsManager.newsItems[indexPath.row]
        cell.newsTitleLabel.text = item.title
        cell.newsSourceLabel.text = item.source?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToURL", sender: self)
    }
    
}

//MARK: - NewsManagerDelegate
extension NewsViewController: NewsManagerDelegate {
    
    func didFailed(error: Error) {
        print(error.localizedDescription)
    }
    
    func updateUI(news: [Article]) {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
            self.newsTableView.isHidden = false
            self.hud?.dismiss(animated: true)
        }
    }
    
}
