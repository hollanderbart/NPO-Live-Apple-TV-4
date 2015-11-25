//
//  ViewController.swift
//  NPO Live
//
//  Created by Maurice van Breukelen on 21-11-15.
//  Copyright © 2015 Maurice van Breukelen. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
	
	var getActiveShowsTimer : NSTimer?
	
	@IBOutlet weak var topCollectionView: UICollectionView!
	@IBOutlet weak var bottomCollectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = bottomCollectionView.frame
		blurEffectView.alpha = 0.5
		view.addSubview(blurEffectView)
		view.bringSubviewToFront(bottomCollectionView)

		getActiveShows()
	}
	
	override func viewWillAppear(animated: Bool) {
		getActiveShowsTimer = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: Selector("getActiveShows"), userInfo: nil, repeats: true)
	}
	
	override func viewWillDisappear(animated: Bool) {
		self.getActiveShowsTimer?.invalidate()
	}
	
	func getActiveShows() {
		ChannelProvider.getActiveShowNamePerChannel { () -> Void in
			self.topCollectionView.reloadData()
		}
	}
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == topCollectionView {
			return 3
		} else if collectionView == bottomCollectionView {
			return ChannelProvider.streams.count - 3
		}
		
		return 0
	}

	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell : UICollectionViewCell!
		if collectionView == topCollectionView {
			cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChannelCell", forIndexPath: indexPath) as! BigChannelCell
			(cell as! BigChannelCell).channel = ChannelProvider.streams[indexPath.row]
		} else {
			cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChannelCell", forIndexPath: indexPath) as! SmallChannelCell
			(cell as! SmallChannelCell).channel = ChannelProvider.streams[indexPath.row + 3]
		}
		
		return cell
	}
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		
		let channel : Channel!
		if collectionView == topCollectionView {
			channel = ChannelProvider.streams[indexPath.row]
		} else {
			channel = ChannelProvider.streams[indexPath.row + 3]
		}
		
		ChannelProvider.getStream(channel) { stream in
			self.performSegueWithIdentifier("streamChannel", sender: channel)
		}
    }
}

// MARK: - Navigation
extension ViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "streamChannel" {
            guard let
                destinationVC = segue.destinationViewController as? PlayerViewController,
                channel = sender as? Channel else { return }
            
            destinationVC.channel = channel
        }
    }
}