//
//  ViewController.swift
//  JsInterface
//
//  Created by Ajithram on 17/03/20.
//  Copyright © 2020 Ajithram. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView: WKWebView = WKWebView()
    let customName = "customName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWkWebView()
    }
    
    func configureWkWebView() {
        let config = WKWebViewConfiguration()
        config.userContentController.add(self, name: customName)
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), configuration: config)
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.load(URLRequest(url: url))
        }
        view.addSubview(webView)
    }

}


extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
        if message.name == customName {
            print(message.body)
            let alert = UIAlertController(title: message.name, message: "This alert is from native", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
