//
//  RedditPost.h
//  PlasticHavas
//
//  Created by David on 2020-10-30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RedditPost : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *ups;
@property (strong, nonatomic) NSString *selftext;
@property (strong, nonatomic) NSNumber *num_comments;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *thumbnail;
@property (strong, nonatomic) NSString *post_hint;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSNumber *thumbnail_width;
@property (strong, nonatomic) NSNumber *thumbnail_height;

@end

NS_ASSUME_NONNULL_END
