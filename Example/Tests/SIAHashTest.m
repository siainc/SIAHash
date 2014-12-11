//
//  SIAHashTest.m
//  SIAHash
//
//  Created by KUROSAKI Ryota on 2014/12/11.
//  Copyright (c) 2014年 KUROSAKI Ryota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <SIAHash.h>

@interface SIAHashTest : XCTestCase

@end

@implementation SIAHashTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStringHash {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    
    XCTAssertEqualObjects(@"TEST".sia_md5Hash, @"033bd94b1168d7e4f0d644c3c95e35bf");
    XCTAssertEqualObjects(@"TEST".sia_sha1Hash, @"984816fd329622876e14907634264e6f332e9fb3");
    XCTAssertEqualObjects(@"TEST".sia_sha224Hash, @"917ecca24f3e6ceaf52375d8083381f1f80a21e6e49fbadc40afeb8e");
    XCTAssertEqualObjects(@"TEST".sia_sha256Hash, @"94ee059335e587e501cc4bf90613e0814f00a7b08bc7c648fd865a2af6a22cc2");
    XCTAssertEqualObjects(@"TEST".sia_sha384Hash, @"4f37c49c0024445f91977dbc47bd4da9c4de8d173d03379ee19c2bb15435c2c7e624ea42f7cc1689961cb7aca50c7d17");
    XCTAssertEqualObjects(@"TEST".sia_sha512Hash, @"7bfa95a688924c47c7d22381f20cc926f524beacb13f84e203d4bd8cb6ba2fce81c57a5f059bf3d509926487bde925b3bcee0635e4f7baeba054e5dba696b2bf");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
