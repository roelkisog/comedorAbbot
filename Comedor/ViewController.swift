//
//  ViewController.swift
//  Comedor
//
//  Created by Reinier Isalgue on 1/15/18.
//  Copyright © 2018 Reinier Isalgue. All rights reserved.
//

import UIKit

import NVActivityIndicatorView

import SwiftMessages

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var reload:UIButton!
    @IBOutlet weak var webView: UIWebView!
    let loading = ActivityData()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.LoadWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Actions
    @IBAction func LoadWebView(){
        reload.isHidden = true
        let myPage = "http://abbott.humandatamanager.com/client"
        let url = NSURL.init(string: myPage)
        let request = NSURLRequest(url: url! as URL)
        //webView.delegate = self
        webView.loadRequest(request as URLRequest)
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(loading)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SwiftMessageAlert(theme: .error, title: "Abbott", body: error.localizedDescription)
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        reload.isHidden = false
    }
}

extension UIViewController {
    func SwiftMessageAlert(layout: MessageView.Layout = .cardView, theme: Theme = .success, title: String = "", body: String = "", completation: (() -> Void)? = nil){
        let alert = MessageView.viewFromNib(layout: layout)
        alert.configureTheme(theme)
        alert.configureContent(title: title, body: body)
        alert.button?.isHidden = true
        alert.configureDropShadow()
        SwiftMessages.show(view: alert)
        if (completation != nil) {
            DispatchQueue.main.asyncAfter(
                deadline: DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: completation!)
        }
    }
}

