//
//  ParametersCheckingTests.swift
//  SwiftHookTests
//
//  Created by Yanni Wang on 20/5/20.
//  Copyright © 2020 Yanni. All rights reserved.
//

import XCTest
@testable import SwiftHook

class ParametersCheckingTests: XCTestCase {
    
    func testCanNotHookClassWithObjectAPI() {
        do {
            try hookBefore(object: randomTestClass(), selector: randomSelector(), closure: {
            })
            XCTAssertTrue(false)
        } catch SwiftHookError.canNotHookClassWithObjectAPI {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookAfter(object: randomTestClass(), selector: randomSelector(), closure: {
            })
            XCTAssertTrue(false)
        } catch SwiftHookError.canNotHookClassWithObjectAPI {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookInstead(object: randomTestClass(), selector: randomSelector(), closure: {
            })
            XCTAssertTrue(false)
        } catch SwiftHookError.canNotHookClassWithObjectAPI {
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func testHookSwiftObjectDealloc() {
        do {
            try hookBefore(object: TestObject(), selector: deallocSelector, closure: {
            })
            XCTAssertTrue(false)
        } catch SwiftHookError.unsupportHookPureSwiftObjectDealloc {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookAfter(object: TestObject(), selector: deallocSelector, closure: {
            })
            XCTAssertTrue(false)
        } catch SwiftHookError.unsupportHookPureSwiftObjectDealloc {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookInstead(object: TestObject(), selector: deallocSelector, closure: {
            })
            XCTAssertTrue(false)
        } catch SwiftHookError.unsupportHookPureSwiftObjectDealloc {
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func testNoRespondSelector() {
        do {
            try hookBefore(targetClass: randomTestClass(), selector: #selector(NSArray.object(at:)), closure: {})
            XCTAssertTrue(false)
        } catch SwiftHookError.noRespondSelector {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookClassMethodAfter(targetClass: TestObject.self, selector: #selector(TestObject.noArgsNoReturnFunc), closure: {})
            XCTAssertTrue(false)
        } catch SwiftHookError.noRespondSelector {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookInstead(object: TestObject(), selector: #selector(TestObject.classMethodNoArgsNoReturnFunc), closure: {})
            XCTAssertTrue(false)
        } catch SwiftHookError.noRespondSelector {
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func testMissingSignature() {
        do {
            try hookBefore(targetClass: randomTestClass(), selector: #selector(TestObject.noArgsNoReturnFunc), closure: NSObject())
            XCTAssertTrue(false)
        } catch SwiftHookError.missingSignature {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookClassMethodAfter(targetClass: TestObject.self, selector: #selector(TestObject.classMethodNoArgsNoReturnFunc), closure: 1)
            XCTAssertTrue(false)
        } catch SwiftHookError.missingSignature {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookInstead(object: TestObject(), selector: #selector(TestObject.noArgsNoReturnFunc), closure: {} as AnyObject)
            XCTAssertTrue(false)
        } catch SwiftHookError.missingSignature {
        } catch {
            XCTAssertNil(error)
        }
    }
        
    func testIncompatibleClosureSignature() {
        do {
            try hookBefore(targetClass: TestObject.self, selector: #selector(TestObject.sumFunc(a:b:)), closure: { _, _ in
                return 1
                } as @convention(block) (Int, Int) -> Int as AnyObject)
            XCTAssertTrue(false)
        } catch SwiftHookError.incompatibleClosureSignature {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookAfter(object: TestObject(), selector: #selector(TestObject.sumFunc(a:b:)), closure: { _, _ in
                } as @convention(block) (Int, Double) -> Void as AnyObject)
            XCTAssertTrue(false)
        } catch SwiftHookError.incompatibleClosureSignature {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookAfter(object: TestObject(), selector: #selector(TestObject.testStructSignature(point:rect:)), closure: ({_, _ in
                } as @convention(block) (CGPoint, Double) -> Void) as AnyObject)
            XCTAssertTrue(false)
        } catch SwiftHookError.incompatibleClosureSignature {
        } catch {
            XCTAssertNil(error)
        }
        do {
            try hookInstead(targetClass: TestObject.self, selector: #selector(TestObject.sumFunc(a:b:)), closure: { _, _ in
                } as @convention(block) (Int, Int) -> Void as AnyObject)
            XCTAssertTrue(false)
        } catch SwiftHookError.incompatibleClosureSignature {
        } catch {
            XCTAssertNil(error)
        }
    }
    
}
