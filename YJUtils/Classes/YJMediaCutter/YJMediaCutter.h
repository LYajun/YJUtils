//
//  YJMediaCutter.h
//  Pods-YJUtils_Example
//
//  Created by 刘亚军 on 2019/10/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJMediaCutter : NSObject
/** 媒体路径 */
@property (nonatomic,copy) NSString *mediaUrl;
/** 剪辑开始时间 */
@property (nonatomic,assign) NSTimeInterval cutStartTime;
/** 剪辑结束时间 */
@property (nonatomic,assign) NSTimeInterval cutEndTime;
/** 媒体ID,确保唯一性 */
@property (nonatomic,copy) NSString *mediaID;


+ (YJMediaCutter *)shareMediaCutter;

- (void)videoCutWithCompletionHandler:(void (^ _Nullable) (NSError * _Nullable error))completionHandler;
- (void)videoSrtCutWithSrtInfo:(NSDictionary *)srtInfo completionHandler:(void (^ _Nullable) (NSDictionary * _Nullable srtInfo))completionHandler;

- (void)audioCutWithCompletionHandler:(void (^ _Nullable) (NSError * _Nullable error))completionHandler;
- (void)audioLrcCutWithLrcInfo:(NSDictionary *)lrcInfo completionHandler:(void (^ _Nullable) (NSDictionary * _Nullable lrcInfo))completionHandler;

- (NSString *)outPutFilePath;
- (void)removeAllCutFile;
@end

NS_ASSUME_NONNULL_END
