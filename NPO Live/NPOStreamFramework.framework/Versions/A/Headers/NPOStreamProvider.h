//
//  NPOStreamProvider.h
//  NPO_Port
//
//  Created by Maurice van Breukelen on 23-11-15.
//  Copyright © 2015 Maurice van Breukelen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPOStreamProvider : NSObject

+ (void) getStream: (NSURL*) streamURL onCompletion:(void (^)(NSURL*))completionBlock;

@end
