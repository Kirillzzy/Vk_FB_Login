//
//  ViewController.swift
//  VKAuthTest
//
//  Created by Kirill Averyanov on 25/02/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit
import SafariServices

let kSafariViewControllerCloseNotification = "kSafariViewControllerCloseNotification"

class ViewController: UIViewController, SFSafariViewControllerDelegate {

  var safariVC: SFSafariViewController?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.safariLogin(_:)), name: Notification.Name(rawValue: kSafariViewControllerCloseNotification), object: nil)
    // Do any additional setup after loading the view, typically from a nib.
  }

  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    
    controller.dismiss(animated: true, completion: nil)
  }

  func safariLogin(_ notification: Notification) {
    // get the url form the auth callback
    let url = notification.object as! URL
    // then do whatever you like, for example :
    // get the code (token) from the URL
    // and do a request to get the information you need (id, name, ...)
    // Finally dismiss the Safari View Controller with:
    print(url)
    self.safariVC!.dismiss(animated: true, completion: nil)
  }


  @IBAction func buttonPressed(_ sender: Any) {
    let redirect = "https://oauth.vk.com/blank.html"
    let url = URL(string: "https://oauth.vk.com/authorize?client_id=5894705&display=popup&redirect_uri=\(redirect)&scope=friends&response_type=token&v=5.62&state=123456")!
    safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: true)
    safariVC!.delegate = self
    self.present(safariVC!, animated: true, completion: nil)

  }

}

