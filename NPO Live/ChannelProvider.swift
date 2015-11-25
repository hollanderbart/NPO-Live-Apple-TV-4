//
//  ChannelProvider.swift
//  NPO Live
//
//  Created by Maurice van Breukelen on 25-11-15.
//  Copyright © 2015 Maurice van Breukelen. All rights reserved.
//

import Foundation

class ChannelProvider {
	
	static let streams = [
		Channel(
			title: "NPO 1",
			urlForShowInformation: NSURL(string: "http://www.npo.nl/live/npo-1"),
			url: NSURL(type: .Live, name: "ned1")),
		Channel(
			title: "NPO 2",
			urlForShowInformation: NSURL(string: "http://www.npo.nl/live/npo-2"),
			url: NSURL(type: .Live, name: "ned2")),
		Channel(
			title: "NPO 3",
			urlForShowInformation: NSURL(string: "http://www.npo.nl/live/npo-3"),
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
	
	class func getStream(channel: Channel, onCompletion: (NSURL) -> Void) {
		if let url = channel.url {
			NPOStreamProvider.getStream(url, onCompletion: { stream in
				channel.streamUrl = stream
				onCompletion(stream)
			})
		}
	}
	
	class func getActiveShowNamePerChannel(onCompletion: () -> Void) {
		let url = NSURL(string: "https://www.tvgids24.nl/nustraks")!
		let task = NSURLSession.sharedSession().dataTaskWithURL(url) { data, _, error in
			if error == nil {
				guard let
					data = data,
					content = String(data: data, encoding: NSUTF8StringEncoding) else { return }
				
				let matches = matchesForRegexInText("<a class=\"prog\".+>(.+)<\\/a><\\/li>", text: content)
				var showsChanged = false
				for (i, match) in matches.enumerate() {
					if i < 3 /* cookies! */ {
						if let showName = match.sliceFrom(">", to: "<")?.htmlDecoded() {
							let channel = ChannelProvider.streams[i]
							if channel.activeShow != showName {
								channel.activeShow = showName
								showsChanged = true
							}
						}
					} else {
						if showsChanged {
							dispatch_async(dispatch_get_main_queue()) {
								onCompletion()
							}
						}
						
						break
					}
				}
			}
		}
		
		task.resume()
	}
	
	private class func matchesForRegexInText(regex: String!, text: String!) -> [String] {
		do {
			let regex = try NSRegularExpression(pattern: regex, options: [])
			let nsString = text as NSString
			let results = regex.matchesInString(text, options: [], range: NSMakeRange(0, nsString.length))
			return results.map { nsString.substringWithRange($0.range)}
		} catch {
			return []
		}
	}
	
}