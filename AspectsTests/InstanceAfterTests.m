//
//  InstanceAfterTests.m
//  AspectsTests
//
//  Created by Yanni Wang on 4/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Aspects.h"
#import "TestObjects/TestObject.h"

@interface InstanceAfterTests : XCTestCase

@end

@implementation InstanceAfterTests

- (void)testTriggered
{
    NSError *error = nil;
    TestObject *obj = [[TestObject alloc] init];
    __block BOOL triggered = NO;
    
    [obj aspect_hookSelector:@selector(methodWithExecuted:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        triggered = YES;
    } error:&error];
    XCTAssert(error == nil);
    
    XCTAssert(triggered == NO);
    [obj methodWithExecuted:NULL];
    XCTAssert(triggered == YES);
}

- (void)testOrder
{
    NSError *error = nil;
    TestObject *obj = [[TestObject alloc] init];
    __block BOOL executed = NO;
    
    [obj aspect_hookSelector:@selector(methodWithExecuted:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        XCTAssert(executed == YES);
    } error:&error];
    XCTAssert(error == nil);
    
    [obj methodWithExecuted:&executed];
    XCTAssert(executed == YES);
}

- (void)testMultipleTimes
{
    NSError *error = nil;
    TestObject *obj = [[TestObject alloc] init];
    __block BOOL triggered = NO;
    
    [obj aspect_hookSelector:@selector(methodWithExecuted:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        triggered = YES;
    } error:&error];
    XCTAssert(error == nil);
    
    XCTAssert(triggered == NO);
    [obj methodWithExecuted:NULL];
    XCTAssert(triggered == YES);
    
    triggered = NO;
    [obj methodWithExecuted:NULL];
    XCTAssert(triggered == YES);
}

- (void)testOneTime
{
    NSError *error = nil;
    TestObject *obj = [[TestObject alloc] init];
    __block BOOL triggered = NO;
    
    [obj aspect_hookSelector:@selector(methodWithExecuted:) withOptions:AspectPositionAfter | AspectOptionAutomaticRemoval usingBlock:^(id<AspectInfo> info){
        triggered = YES;
    } error:&error];
    XCTAssert(error == nil);
    
    XCTAssert(triggered == NO);
    [obj methodWithExecuted:NULL];
    XCTAssert(triggered == YES);
    
    triggered = NO;
    [obj methodWithExecuted:NULL];
    XCTAssert(triggered == NO);
}

- (void)testCancel
{
    NSError *error = nil;
    TestObject *obj = [[TestObject alloc] init];
    __block BOOL triggered = NO;
    
    id<AspectToken> token = [obj aspect_hookSelector:@selector(methodWithExecuted:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        triggered = YES;
    } error:&error];
    XCTAssert(error == nil);
    
    XCTAssert(triggered == NO);
    [obj methodWithExecuted:NULL];
    XCTAssert(triggered == YES);
    
    triggered = NO;
    [obj methodWithExecuted:NULL];
    XCTAssert(triggered == YES);
    
    BOOL removed = [token remove];
    XCTAssert(removed == YES);
    
    triggered = NO;
    [obj methodWithExecuted:NULL];
    XCTAssert(triggered == NO);
}

- (void)testNoAffectToOtherInstance
{
    NSError *error = nil;
    TestObject *obj = [[TestObject alloc] init];
    __block BOOL triggered = NO;
    
    [obj aspect_hookSelector:@selector(methodWithExecuted:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        triggered = YES;
    } error:&error];
    XCTAssert(error == nil);
    
    XCTAssert(triggered == NO);
    [obj methodWithExecuted:NULL];
    XCTAssert(triggered == YES);
    
    TestObject *obj2 = [[TestObject alloc] init];
    triggered = NO;
    [obj2 methodWithExecuted:NULL];
    XCTAssert(triggered == NO);
}

@end
