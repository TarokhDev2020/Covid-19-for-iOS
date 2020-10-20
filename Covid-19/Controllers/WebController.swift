//
//  WebController.swift
//  Covid-19
//
//  Created by Tarokh on 8/25/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import WebKit

class WebController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var webView: WKWebView!
    
    
    //MARK: - Variables
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: URL(string: url!)!))
    }

}
