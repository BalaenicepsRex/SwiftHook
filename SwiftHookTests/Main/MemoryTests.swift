//
//  MemoryTests.swift
//  SwiftHookTests
//
//  Created by Yanni Wang on 10/5/20.
//  Copyright © 2020 Yanni. All rights reserved.
//

import XCTest

// This Testcase should be trigger manually.
class MemoryTests: XCTestCase {
    
    func testMemory() {
        while true {
            autoreleasepool {
                
                // MARK: Components
                
                let ffiTypeContextTests = FFITypeContextTests()
                ffiTypeContextTests.testVoid()
                ffiTypeContextTests.testInt8()
                ffiTypeContextTests.testPointerObject()
                ffiTypeContextTests.testPointerDouble()
                ffiTypeContextTests.testVoidAsterisk()
                ffiTypeContextTests.testStructCGRect()
                ffiTypeContextTests.testComplexityStruct()
                
                let sHMethodSignatureTests = SHMethodSignatureTests()
                sHMethodSignatureTests.testNoArgsNoReturnFunc()
                sHMethodSignatureTests.testSimpleSignature()
                sHMethodSignatureTests.testStructSignature()
                sHMethodSignatureTests.testClosureSignature()
                
                let signatureTests = SignatureTests()
                signatureTests.testNoArgsNoReturnFunc()
                signatureTests.testSimpleSignature()
                signatureTests.testStructSignature()
                signatureTests.testClosureSignature()
                
                let hookDeallocAfterDelegateTests = HookDeallocAfterDelegateTests()
                hookDeallocAfterDelegateTests.testSingleClosure()
                hookDeallocAfterDelegateTests.testMultipleClosure()
                hookDeallocAfterDelegateTests.testCancellation()
                
                let dynamicClassTests = DynamicClassTests()
                dynamicClassTests.testNormal()
                dynamicClassTests.testWrapDynamicClass()
                dynamicClassTests.testUnwrapNonDynamicClass()
                
                let hookContextTests = HookContextTests()
                hookContextTests.testNoMethod()
                hookContextTests.testHook()
                hookContextTests.testAppend()
                hookContextTests.testRemove()
                
                let hookInternalTests = HookInternalTests()
                hookInternalTests.testHookClass()
                hookInternalTests.testHookObject()
                hookInternalTests.testDuplicateCancellation()
                hookInternalTests.testDuplicateHookClosure()
                
                // MARK: Main
                
                let compatibilityTests = CompatibilityTests()
                compatibilityTests.testKVO()
                compatibilityTests.testBeforeKVO()
                compatibilityTests.testBeforeKVOReverseCancel()
                compatibilityTests.testAfterKVO()
                compatibilityTests.testAfterKVOReverseCancel()
                
                let specialMethodTests = SpecialMethodTests()
                specialMethodTests.testDeallocForSingleOCObject()
                specialMethodTests.testDeallocForSingleSwiftObject()
                specialMethodTests.testDeallocForAllInstancesOCObject()
                
                let parametersCheckingTests = ParametersCheckingTests()
                parametersCheckingTests.testCanNotHookClassWithObjectAPI()
                parametersCheckingTests.testUnsupportHookPureSwiftObjectDealloc()
                parametersCheckingTests.testNoRespondSelector()
                parametersCheckingTests.testMissingSignature()
                parametersCheckingTests.testIncompatibleClosureSignature()
                
                let allInstancesBeforeTests = AllInstancesBeforeTests()
                allInstancesBeforeTests.testNormal()
                allInstancesBeforeTests.testCheckArguments()
                
                let allInstancesAfterTests = AllInstancesAfterTests()
                allInstancesAfterTests.testNormal()
                allInstancesAfterTests.testCheckArguments()
                
                let allInstancesInsteadTests = AllInstancesInsteadTests()
                allInstancesInsteadTests.testCallOriginal()
                allInstancesInsteadTests.testOverrideOriginal()
                allInstancesInsteadTests.testChangeArgs()
                allInstancesInsteadTests.testNonCallOriginal()
                allInstancesInsteadTests.testCallOriginalForClosure()
                allInstancesInsteadTests.testHookTwice()
                allInstancesInsteadTests.testChangeReturn()
                
                let classMethodBeforeTests = ClassMethodBeforeTests()
                classMethodBeforeTests.testNormal()
                classMethodBeforeTests.testCheckArguments()
                
                let classMethodAfterTests = ClassMethodAfterTests()
                classMethodAfterTests.testNormal()
                classMethodAfterTests.testCheckArguments()
                
                let classMethodInsteadTests = ClassMethodInsteadTests()
                classMethodInsteadTests.testCallOriginal()
                classMethodInsteadTests.testOverrideOriginal()
                classMethodInsteadTests.testChangeArgs()
                classMethodInsteadTests.testNonCallOriginal()
                classMethodInsteadTests.testCallOriginalForClosure()
                classMethodInsteadTests.testHookTwice()
                classMethodInsteadTests.testChangeReturn()
                
                let singleInstancesBeforeTests = SingleInstancesBeforeTests()
                singleInstancesBeforeTests.testNormal()
                singleInstancesBeforeTests.testCheckArguments()
                
                let singleInstancesAfterTests = SingleInstancesAfterTests()
                singleInstancesAfterTests.testNormal()
                singleInstancesAfterTests.testCheckArguments()
                
                let singleInstancesInsteadTests = SingleInstancesInsteadTests()
                singleInstancesInsteadTests.testCallOriginal()
                singleInstancesInsteadTests.testOverrideOriginal()
                singleInstancesInsteadTests.testChangeArgs()
                singleInstancesInsteadTests.testNonCallOriginal()
                singleInstancesInsteadTests.testCallOriginalForClosure()
                singleInstancesInsteadTests.testHookTwice()
                singleInstancesInsteadTests.testHookTwiceWithDifferentMethod()
                singleInstancesInsteadTests.testChangeReturn()
                
            }
        }
    }
    
}
