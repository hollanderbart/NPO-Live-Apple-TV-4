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
	    
    let streams = [
        Channel(
            title: "NPO 1",
            url: NSURL(type: .Live, name: "ned1")),
        Channel(
            title: "NPO 2",
            url: NSURL(type: .Live, name: "ned2")),
		Channel(
			title: "NPO 3",
			url: NSURL(type: .Live, name: "ned3")),
		Channel(
			title: "NPO Nieuws",
			url: NSURL(type: .Thema, name: "journaal24")),
		Channel(
			title: "NPO Politiek",
			url: NSURL(type: .Thema, name: "politiek24")),
		Channel(
			title: "NPO Best",
			url: NSURL(type: .Thema, name: "best24")),
		Channel(
			title: "NPO Doc",
			url: NSURL(type: .Thema, name: "hollanddoc24")),
		Channel(
			title: "NPO 101",
			url: NSURL(type: .Thema, name: "101tv")),
		Channel(
			title: "NPO Cultura",
			url: NSURL(type: .Thema, name: "cultura24")),
		Channel(
			title: "NPO Zapp Xtra",
			url: NSURL(type: .Thema, name: "zappelin24")),
		Channel(
			title: "NPO Humor tv",
			url: NSURL(type: .Thema, name: "humor24"))
	]
	
	@IBOutlet weak var collectionView: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return streams.count
	}

	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChannelCell", forIndexPath: indexPath) as! ChannelCell
		cell.channel = streams[indexPath.row]
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		let width = (collectionView.frame.width - (2 * 10)) / 3
		return CGSize(width: width, height: 250)
	}
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let channel = streams[indexPath.row]
		
		if let url = channel.url {
			NPOStreamProvider.getStream(url, onCompletion: { stream in
				channel.streamUrl = stream
				self.performSegueWithIdentifier("streamChannel", sender: channel)
			})
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