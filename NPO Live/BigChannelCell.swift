//
//  BigChannelCell.swift
//  Design
//
//  Created by Maurice van Breukelen on 24-11-15.
//  Copyright © 2015 Maurice van Breukelen. All rights reserved.
//

import UIKit

class BigChannelCell: UICollectionViewCell {
	
	@IBOutlet weak var logoView: UIImageView!
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var labelBottomConstraint: NSLayoutConstraint!
	
	var channel: Channel? {
		didSet {
			setupCell()
		}
	}
	
	func setupCell() {
		guard let channel = channel else { return }
		logoView.image = UIImage(named: channel.title)
		label.text = channel.activeShow
	}
	
	func focus() {
		layoutIfNeeded()
		labelBottomConstraint.constant = 20
		
		self.label.textColor = UIColor.whiteColor()
		self.label.layer.shadowOpacity = 0.5
		self.label.layer.shadowRadius = 10.0
		self.label.layer.shadowColor = UIColor.blackColor().CGColor
		self.label.layer.shadowOffset = CGSize(width: 0, height: 1)
		
		UIView.animateWithDuration(0.2) {
			self.layoutIfNeeded()
		}
	}
	
	func unfocus() {
		layoutIfNeeded()
		labelBottomConstraint.constant = 0

		self.label.textColor = UIColor.darkGrayColor()

		UIView.animateWithDuration(0.2) {
			self.layoutIfNeeded()
			self.label.layer.shadowOpacity = 0
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
