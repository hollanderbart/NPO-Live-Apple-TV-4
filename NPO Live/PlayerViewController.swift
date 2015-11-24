//
//  PlayerViewController.swift
//  NPO Live
//
//  Created by Maurice van Breukelen on 21-11-15.
//  Copyright © 2015 Maurice van Breukelen. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {
	
	var channel: Channel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        guard let streamURL = channel.streamUrl else { return }
		let playerItem = AVPlayerItem(URL: streamURL)
		
        let titleMetadataItem: AVMetadataItem = {
            let _titleMetadataItem = AVMutableMetadataItem()
            _titleMetadataItem.locale = NSLocale.currentLocale()
            _titleMetadataItem.key = AVMetadataCommonKeyTitle
            _titleMetadataItem.keySpace = AVMetadataKeySpaceCommon
            _titleMetadataItem.value = channel.title
            
            return _titleMetadataItem
        }()
        
		playerItem.externalMetadata.append(titleMetadataItem)
		
		if let image = UIImage(named: channel.title) {
            let logo: AVMetadataItem = {
                let _logo = AVMutableMetadataItem()
                _logo.locale = NSLocale.currentLocale()
                _logo.key = AVMetadataCommonKeyArtwork
                _logo.keySpace = AVMetadataKeySpaceCommon
                _logo.value = UIImagePNGRepresentation(image)
                
                return _logo
            }()
            
			playerItem.externalMetadata.append(logo)
		}
		
		player = AVPlayer(playerItem: playerItem)
		player?.play()
    }
}