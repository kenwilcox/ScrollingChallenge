//
//  GameScene.m
//  ScrollingChallenge
//
//  Created by Kenneth Wilcox on 11/7/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "GameScene.h"
#import "TileNode.h"

@implementation GameScene
{
  TileNode *_leftmostTile;
  TileNode *_rightmostTile;
  int _direction;
}

static const CGFloat kScrollSpeed = 70.0;

- (instancetype)initWithSize:(CGSize)size
{
  if (self = [super initWithSize:size]) {
    self.backgroundColor = [SKColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0];
    
    _leftmostTile = nil;
    _rightmostTile = nil;
    _direction = -1;
    
    for (int i = 0; i < 3; i++) {
      TileNode *tile = [TileNode spriteNodeWithImageNamed:@"desert_BG.png"];
      tile.anchorPoint = CGPointZero;
      
      if (!_leftmostTile) {
        _leftmostTile = tile;
      }
      
      if (_rightmostTile) {
        tile.position = CGPointMake(_rightmostTile.position.x + _rightmostTile.size.width, _rightmostTile.position.y);
      } else {
        tile.position = CGPointZero;
      }
      
      tile.prevTile = _rightmostTile;
      _rightmostTile.nextTile = tile;
      _rightmostTile = tile;
      
      [self addChild:tile];
    }
    
    _leftmostTile.prevTile = _rightmostTile;
    _rightmostTile.nextTile = _leftmostTile;
    
  }
  return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  /* Called when a touch begins */
  _direction *= -1;
}

- (void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
  static CFTimeInterval lastCallTime;
  CFTimeInterval timeElapsed = currentTime - lastCallTime;
  if (timeElapsed > 10.0 / 60.0) {
    timeElapsed = 10.0 / 60.0;
  }
  lastCallTime = currentTime;
  
  CGFloat scrollDistance = kScrollSpeed * timeElapsed;
  
  TileNode *tile = _leftmostTile;
  do {
    tile.position = CGPointMake(tile.position.x + (scrollDistance * _direction), tile.position.y);
    tile = tile.nextTile;
  } while (tile != _leftmostTile);
  
  if (_direction == -1) {
    if (_leftmostTile.position.x + _leftmostTile.size.width < 0) {
      _leftmostTile.position = CGPointMake(_rightmostTile.position.x + _rightmostTile.size.width, _leftmostTile.position.y);
      _rightmostTile = _leftmostTile;
      _leftmostTile = _leftmostTile.nextTile;
    }
  } else {
    if (_rightmostTile.position.x > self.size.width) {
      _rightmostTile.position = CGPointMake(_leftmostTile.position.x - _rightmostTile.size.width, _rightmostTile.position.y);
      _leftmostTile = _rightmostTile;
      _rightmostTile = _rightmostTile.prevTile;
    }
  }
}

@end
