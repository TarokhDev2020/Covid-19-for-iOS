//
//  CountriesViewController.swift
//  Covid-19
//
//  Created by Tarokh on 8/24/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Kingfisher
import JGProgressHUD

class CountriesViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    //MARK: - @IBOutlets
    @IBOutlet var countryTableView: UITableView!
    
    
    //MARK: - Variables
    var countryManager = CountryManager()
    var hud: JGProgressHUD?
    var searchController = UISearchController()
    var filteredData: [Country]?
    var searchActive: Bool = false
    
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        countryTableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "countryCell")
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.isHidden = true
        
        hud = JGProgressHUD(style: .dark)
        hud?.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud?.show(in: self.view, animated: true)
        
        countryManager.delegate = self
        countryManager.getCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.title = "Countries Covid-19"
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        
        let searchBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        searchBarButton.tintColor = .black
        self.tabBarController?.navigationItem.rightBarButtonItem = searchBarButton
        definesPresentationContext = true
    }
    
    
    //MARK: - Functions
    private func formattedNumber(_ covid: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: covid as NSNumber)!
    }
    
    @objc func search() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = nil
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Search by country"
        searchController.searchBar.autocapitalizationType = .none
        self.present(searchController, animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("J")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? countryManager.countryItems : countryManager.countryItems.filter({(dataString: Country) -> Bool in
            return dataString.country!.range(of: searchText, options: .caseInsensitive) != nil
        })

        self.countryTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredData!.count
        }
        else {
            return countryManager.countryItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryCell
        if searchController.isActive == true {
            let item = filteredData![indexPath.row]
            let flag = URL(string: (item.countryInfo?.flag!)!)
            cell.caseLabel.text = "CASES: \(formattedNumber(item.cases!))"
            cell.deathLabel.text = "DEATHS: \(formattedNumber(item.deaths!))"
            cell.recoveredLabel.text = "RECOVERED: \(formattedNumber(item.recovered!))"
            cell.activeLabel.text = "ACTIVE: \(formattedNumber(item.active!))"
            cell.countryImageView.kf.setImage(with: flag!)
            cell.countryLabel.text = item.country
            return cell
        }
        else {
            let item = countryManager.countryItems[indexPath.row]
            let flag = URL(string: (item.countryInfo?.flag!)!)
            cell.caseLabel.text = "CASES: \(formattedNumber(item.cases!))"
            cell.deathLabel.text = "DEATHS: \(formattedNumber(item.deaths!))"
            cell.recoveredLabel.text = "RECOVERED: \(formattedNumber(item.recovered!))"
            cell.activeLabel.text = "ACTIVE: \(formattedNumber(item.active!))"
            cell.countryImageView.kf.setImage(with: flag!)
            cell.countryLabel.text = item.country
            return cell
        }
    }

    
}

//MARK: - CountryManagerDelegate
extension CountriesViewController: CountryManagerDelegate {
    
    func didFailed(error: Error) {
        print(error.localizedDescription)
    }
    
    func updateUI(countries: [Country]) {
        DispatchQueue.main.async {
            self.countryTableView.reloadData()
            self.countryTableView.isHidden = false
            self.hud?.dismiss(animated: true)
        }
    }
    
}
