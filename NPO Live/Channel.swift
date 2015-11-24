//
//  Channel.swift
//  NPO Live
//
//  Created by Bas Broek on 21/11/15.
//  Copyright © 2015 Maurice van Breukelen. All rights reserved.
//

import Foundation

class Channel {
    var title: String
    var url: NSURL?
	var streamUrl : NSURL?
	
	init(title: String, url: NSURL?) {
		self.title = title
		self.url = url
	}
}

enum ChannelType: String {
    case Live = "tvlive"
    case Thema = "thematv"
}