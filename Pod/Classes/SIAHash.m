//
//  SIAHash.m
//  SIATools
//
//  Created by KUROSAKI Ryota on 2011/11/21.
//  Copyright (c) 2011-2014 SI Agency Inc. All rights reserved.
//

#if !__has_feature(objc_arc)
#error This code needs compiler option -fobjc_arc
#endif

#import "SIAHash.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

#define CHUNK_SIZE (1000 * 1000)

NSString *SIACreateHashByMD5(const void *data, unsigned int length)
{
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, length, digest);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

NSString *SIACreateHashBySHA1(const void *data, unsigned int length)
{
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data, length, digest);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

NSString *SIACreateHashBySHA224(const void *data, unsigned int length)
{
    unsigned char digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(data, length, digest);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

NSString *SIACreateHashBySHA256(const void *data, unsigned int length)
{
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data, length, digest);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

NSString *SIACreateHashBySHA384(const void *data, unsigned int length)
{
    unsigned char digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(data, length, digest);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

NSData *SIACreateHmacBySHA256(const void *key, unsigned int keyLength, const void *data, unsigned int dataLength)
{
    unsigned char hmac[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, key, keyLength, data, dataLength, hmac);
    NSData *hash = [[NSData alloc] initWithBytes:hmac length:CC_SHA256_DIGEST_LENGTH];
    return hash;
}

NSString *SIACreateHashBySHA512(const void *data, unsigned int length)
{
    unsigned char digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data, length, digest);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

@implementation NSData (NSDataSIAHashExtension)

- (NSString *)sia_md5Hash
{
    return SIACreateHashByMD5(self.bytes, (unsigned int)self.length);
}

- (NSString *)sia_sha1Hash
{
    return SIACreateHashBySHA1(self.bytes, (unsigned int)self.length);
}

- (NSString *)sia_sha224Hash
{
    return SIACreateHashBySHA224(self.bytes, (unsigned int)self.length);
}

- (NSString *)sia_sha256Hash
{
    return SIACreateHashBySHA256(self.bytes, (unsigned int)self.length);
}

- (NSData *)sia_sha256Hmac:(NSString *)key
{
    return SIACreateHmacBySHA256(key.UTF8String,
                                 (unsigned int)[key lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
                                 self.bytes,
                                 (unsigned int)self.length);
}

- (NSString *)sia_sha384Hash
{
    return SIACreateHashBySHA384(self.bytes, (unsigned int)self.length);
}

- (NSString *)sia_sha512Hash
{
    return SIACreateHashBySHA512(self.bytes, (unsigned int)self.length);
}

@end

@implementation NSString (NSStringSIAHashExtension)

- (NSString *)sia_md5Hash
{
    return SIACreateHashByMD5(self.UTF8String,
                              (unsigned int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
}

- (NSString *)sia_sha1Hash
{
    return SIACreateHashBySHA1(self.UTF8String,
                               (unsigned int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
}

- (NSString *)sia_sha224Hash
{
    return SIACreateHashBySHA224(self.UTF8String,
                                 (unsigned int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
}

- (NSString *)sia_sha256Hash
{
    return SIACreateHashBySHA256(self.UTF8String,
                                 (unsigned int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
}

- (NSData *)sia_sha256Hmac:(NSString *)key
{
    return SIACreateHmacBySHA256(key.UTF8String,
                                 (unsigned int)[key lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
                                 self.UTF8String,
                                 (unsigned int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
}

- (NSString *)sia_sha384Hash
{
    return SIACreateHashBySHA384(self.UTF8String,
                                 (unsigned int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
}

- (NSString *)sia_sha512Hash
{
    return SIACreateHashBySHA512(self.UTF8String,
                                 (unsigned int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
}

@end

@implementation NSFileManager (NSFileManagerSIAHashExtension)

- (NSString *)sia_md5HashAtPath:(NSString *)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if (handle == nil) {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    
    while (YES) {
        @autoreleasepool {
            NSData *fileData = [handle readDataOfLength:CHUNK_SIZE];
            CC_MD5_Update(&md5, fileData.bytes, (unsigned int)fileData.length);
            if (fileData.length == 0) {
                break;
            }
        }
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

- (NSString *)sia_sha1HashAtPath:(NSString *)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if (handle == nil) {
        return nil;
    }
    
    CC_SHA1_CTX sha1;
    CC_SHA1_Init(&sha1);
    
    while (YES) {
        @autoreleasepool {
            NSData *fileData = [handle readDataOfLength:CHUNK_SIZE];
            CC_SHA1_Update(&sha1, fileData.bytes, (unsigned int)fileData.length);
            if (fileData.length == 0) {
                break;
            }
        }
    }
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(digest, &sha1);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

- (NSString *)sia_sha224HashAtPath:(NSString *)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if (handle == nil) {
        return nil;
    }
    
    CC_SHA256_CTX sha224;
    CC_SHA224_Init(&sha224);
    
    while (YES) {
        @autoreleasepool {
            NSData *fileData = [handle readDataOfLength:CHUNK_SIZE];
            CC_SHA224_Update(&sha224, fileData.bytes, (unsigned int)fileData.length);
            if (fileData.length == 0) {
                break;
            }
        }
    }
    
    unsigned char digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224_Final(digest, &sha224);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

- (NSString *)sia_sha256HashAtPath:(NSString *)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if (handle == nil) {
        return nil;
    }
    
    CC_SHA256_CTX sha256;
    CC_SHA256_Init(&sha256);
    
    while (YES) {
        @autoreleasepool {
            NSData *fileData = [handle readDataOfLength:CHUNK_SIZE];
            CC_SHA256_Update(&sha256, fileData.bytes, (unsigned int)fileData.length);
            if (fileData.length == 0) {
                break;
            }
        }
    }
    
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_Final(digest, &sha256);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

- (NSString *)sia_sha384HashAtPath:(NSString *)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if (handle == nil) {
        return nil;
    }
    
    CC_SHA512_CTX sha384;
    CC_SHA384_Init(&sha384);
    
    while (YES) {
        @autoreleasepool {
            NSData *fileData = [handle readDataOfLength:CHUNK_SIZE];
            CC_SHA384_Update(&sha384, fileData.bytes, (unsigned int)fileData.length);
            if (fileData.length == 0) {
                break;
            }
        }
    }
    
    unsigned char digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384_Final(digest, &sha384);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

- (NSString *)sia_sha512HashAtPath:(NSString *)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if (handle == nil) {
        return nil;
    }
    
    CC_SHA512_CTX sha512;
    CC_SHA512_Init(&sha512);
    
    while (YES) {
        @autoreleasepool {
            NSData *fileData = [handle readDataOfLength:CHUNK_SIZE];
            CC_SHA512_Update(&sha512, fileData.bytes, (unsigned int)fileData.length);
            if (fileData.length == 0) {
                break;
            }
        }
    }
    
    unsigned char digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512_Final(digest, &sha512);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    return hash;
}

@end

