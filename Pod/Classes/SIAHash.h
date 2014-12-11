//
//  SIAHash.h
//  SIATools
//
//  Created by KUROSAKI Ryota on 2011/11/21.
//  Copyright (c) 2011-2014 SI Agency Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *SIACreateHashByMD5(const void *data, unsigned int length);
NSString *SIACreateHashBySHA1(const void *data, unsigned int length);
NSString *SIACreateHashBySHA224(const void *data, unsigned int length);
NSString *SIACreateHashBySHA256(const void *data, unsigned int length);
NSData   *SIACreateHmacBySHA256(const void *key, unsigned int keyLength, const void *data, unsigned int dataLength);
NSString *SIACreateHashBySHA384(const void *data, unsigned int length);
NSString *SIACreateHashBySHA512(const void *data, unsigned int length);

@interface NSData (NSDataSIAHashExtension)
- (NSString *)sia_md5Hash;
- (NSString *)sia_sha1Hash;
- (NSString *)sia_sha224Hash;
- (NSString *)sia_sha256Hash;
- (NSData *)sia_sha256Hmac:(NSString *)key;
- (NSString *)sia_sha384Hash;
- (NSString *)sia_sha512Hash;
@end

@interface NSString (NSStringSIAHashExtension)
- (NSString *)sia_md5Hash;
- (NSString *)sia_sha1Hash;
- (NSString *)sia_sha224Hash;
- (NSString *)sia_sha256Hash;
- (NSData *)sia_sha256Hmac:(NSString *)key;
- (NSString *)sia_sha384Hash;
- (NSString *)sia_sha512Hash;
@end

@interface NSFileManager (NSFileManagerSIAHashExtension)
- (NSString *)sia_md5HashAtPath:(NSString *)path;
- (NSString *)sia_sha1HashAtPath:(NSString *)path;
- (NSString *)sia_sha224HashAtPath:(NSString *)path;
- (NSString *)sia_sha256HashAtPath:(NSString *)path;
- (NSString *)sia_sha384HashAtPath:(NSString *)path;
- (NSString *)sia_sha512HashAtPath:(NSString *)path;
@end
