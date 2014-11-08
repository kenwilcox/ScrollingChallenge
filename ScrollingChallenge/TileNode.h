//
//  TileNode.h
//  ScrollingChallenge
//
//  Created by Kenneth Wilcox on 11/8/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TileNode : SKSpriteNode
@property (nonatomic) TileNode *nextTile;
@property (nonatomic) TileNode *prevTile;
@end
