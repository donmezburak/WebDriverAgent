/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <XCTest/XCTest.h>

#import <WebDriverAgentLib/FBDebugLogDelegateDecorator.h>
#import <WebDriverAgentLib/FBConfiguration.h>
#import <WebDriverAgentLib/FBFailureProofTestCase.h>
#import <WebDriverAgentLib/XCTestCase.h>
#import "../WebDriverAgentLib/Routing/NNGServer.h"
#import "../WebDriverAgentLib/Routing/NNGServer2.h"

@interface UITestingUITests : FBFailureProofTestCase
@end

@implementation UITestingUITests

+ (void)setUp
{
  [FBDebugLogDelegateDecorator decorateXCTestLogger];
  [FBConfiguration disableRemoteQueryEvaluation];
  [FBConfiguration configureDefaultKeyboardPreferences];
  [FBConfiguration disableApplicationUIInterruptionsHandling];
  if (NSProcessInfo.processInfo.environment[@"ENABLE_AUTOMATIC_SCREENSHOTS"]) {
    [FBConfiguration enableScreenshots];
  } else {
    [FBConfiguration disableScreenshots];
  }
  [super setUp];
}

/**
 Never ending test used to start WebDriverAgent
 */
- (void)testRunner
{
  NngThread2 *nngThreadInst2 = [[NngThread2 alloc] init:8102];
     [NSThread detachNewThreadSelector:@selector(entry:) toTarget:nngThreadInst2 withObject:nil];

     NngThread *nngThreadInst = [[NngThread alloc] init:8101];
     //[NSThread detachNewThreadSelector:@selector(entry:) toTarget:nngThreadInst withObject:nil];
     [nngThreadInst entry:self];
}

@end
