//
//  AppDelegate.swift
//  NPO Live
//
//  Created by Maurice van Breukelen on 21-11-15.
//  Copyright © 2015 Maurice van Breukelen. All rights reserved.
//

import UIKit

let gitHubURL = "https://api.github.com/repos/Mauricevb/NPO-Live-Apple-TV-4/releases"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		checkForNewVersions()
		return true
	}
	
	func checkForNewVersions() {
		guard let currentVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String else { return }
		
		let URL = NSURL(string: gitHubURL)
		let request = NSMutableURLRequest(URL: URL!)
		request.HTTPMethod = "GET"
		request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
		
		let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, _, error) in
			if error == nil {
				guard let data = data else { return }
				do {
					guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [AnyObject] else { return }
					guard let lastVersion = json[0] as? NSDictionary where lastVersion["tag_name"] != nil else { return }
					let version = lastVersion["tag_name"] as! String
					
					if version > currentVersion {
						let alert = UIAlertController(title: "Update available", message: "Version \(version) is available. Your version is \(currentVersion)", preferredStyle: UIAlertControllerStyle.Alert)
						alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
						
						dispatch_async(dispatch_get_main_queue()) {
							if let vc = self.window?.rootViewController {
								vc.presentViewController(alert, animated: true, completion: nil)
							}
						}
					}
				} catch {
					print(error)
				}
			}
		}
		
		task.resume()
	}
}