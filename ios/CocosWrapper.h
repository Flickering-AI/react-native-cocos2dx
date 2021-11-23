//
//  CocosWrapper.h.h
//  Pods
//
//  Created by Xuanping Liu on 2021/11/11.
//

#ifndef CocosWrapper_h_h
#define CocosWrapper_h_h

@interface CocosWrapper : NSObject
+(UIView *) glview;
+(void) setBridge:(RCTBridge *)bridge;
@end

#endif /* CocosWrapper_h_h */
