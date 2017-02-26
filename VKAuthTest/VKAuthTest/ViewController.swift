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
  var haveSafariVC: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()
    print("vk: ", vkAppMayExists())
    print("fb: ", fbAppMayExists())
    NotificationCenter.default.addObserver(self, selector: #selector(self.safariLogin(_:)), name: Notification.Name(rawValue: kSafariViewControllerCloseNotification), object: nil)
    // Do any additional setup after loading the view, typically from a nib.
  }

  func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
    haveSafariVC = true
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
    if haveSafariVC{
      self.safariVC!.dismiss(animated: true, completion: nil)
      haveSafariVC = false
    }
  }

  func vkAppMayExists() -> Bool{
    return UIApplication.shared.canOpenURL(URL(string: "vkauthorize://")!)
  }

  func fbAppMayExists() -> Bool{
    return UIApplication.shared.canOpenURL(URL(string: "fb://authorize")!)
  }

  @IBAction func vkButtonPressed(_ sender: Any) {
    if !vkAppMayExists(){
      let url = URL(string: "https://oauth.vk.com/authorize?revoke=1&response_type=token&display=mobile&scope=photos,wall,messages,friends,email,offline,nohttps,audio&v=5.40&redirect_uri=vk5894705://authorize&sdk_version=1.4.6&client_id=5894705")!
      safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: true)
      safariVC!.delegate = self
      self.present(safariVC!, animated: true, completion: nil)
    } else {
      let url = URL(string: "vkauthorize://authorize?sdk_version=1.4.6&client_id=5894705&scope=photos,wall,messages,friends,email,offline,nohttps,audio&revoke=1&v=5.40")!
      UIApplication.shared.open(url, options: [:])
    }
  }

  @IBAction func fbButtonPressed(_ sender: Any) {
//    if !fbAppMayExists(){
      let url = URL(string: "https://www.facebook.com/v2.8/dialog/oauth?client_id=612769202252885&redirect_uri=fb612769202252885://authorize")!
      safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: true)
      safariVC!.delegate = self
      self.present(safariVC!, animated: true, completion: nil)
//    } else {
//      let url = URL(string: "fb://authorize?client_id=612769202252885")!
//      UIApplication.shared.open(url, options: [:])
//    }
  }
}

