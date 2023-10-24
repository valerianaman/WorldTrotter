//
//  WebController.swift
//  WorldTrotter
//
//  Created by Gonzalo Benítez Bueno on 24/10/23.
//

import UIKit
import WebKit

class webController: UIViewController{
    
    var webView:  WKWebView! = nil
    
    
    override func loadView() {
        
        let webConfig = WKWebViewConfiguration()
        
        webView = WKWebView(frame: .zero, configuration: webConfig)
        
        view = webView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://google.com")
        let myRequest = URLRequest(url: myURL!)
        
        webView.load(myRequest)

    }
    
    
    
    
    
}
