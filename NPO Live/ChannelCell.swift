//
//  ChannelCell.swift
//  NPO Live
//
//  Created by Maurice van Breukelen on 21-11-15.
//  Copyright © 2015 Maurice van Breukelen. All rights reserved.
//

import Foundation
import UIKit

class ChannelCell: UICollectionViewCell {
	
	@IBOutlet weak var logoView: UIImageView!
	
	var channel: Channel? {
		didSet {
			setupCell()
		}
	}
	
	func setupCell() {
        guard let channel = channel else { return }
        logoView.image = UIImage(named: channel.title)
	}

	func focus() {
		UIView.animateWithDuration(0.2) {
			self.logoView.transform = CGAffineTransformMakeScale(1.4, 1.4)
		}
	}
	
	func unfocus() {
		UIView.animateWithDuration(0.2) {
			self.logoView.transform = CGAffineTransformMakeScale(1.0, 1.0)
		}
	}
	
	override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
		if focused {
			focus()
		} else {
			unfocus()
		}
	}
}