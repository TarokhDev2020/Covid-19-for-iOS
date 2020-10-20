//
//  ViewController.swift
//  Covid-19
//
//  Created by Tarokh on 8/23/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit

class GlobalViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var casesLabel: UILabel!
    @IBOutlet var deathsLabel: UILabel!
    @IBOutlet var recoveredLabel: UILabel!
    @IBOutlet var affectedLabel: UILabel!
    

    
    
    //MARK: - Variables
    var covidManager = GlobalManager()
    let date = Date()
    
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = covidManager.getDate()
        
        covidManager.delegate = self
        covidManager.getCovid()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.title = "Covid-19"
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
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

}

//MARK: - CovidManagerDelegate
extension GlobalViewController: GlobalManagerDelegate {
    
    func didFailed(error: Error) {
        print(error.localizedDescription)
    }
    
    func updateUI(covid: Global) {
        self.casesLabel.text = formattedNumber(covid.cases)
        self.deathsLabel.text = formattedNumber(covid.deaths)
        self.recoveredLabel.text = formattedNumber(covid.recovered)
        self.affectedLabel.text = "\(covid.affectedCountries)"
    }
    
}

