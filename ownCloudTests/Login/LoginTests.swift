//
//  LoginTests.swift
//  ownCloudTests
//
//  Created by Javier Gonzalez on 19/07/2018.
//  Copyright © 2018 ownCloud GmbH. All rights reserved.
//

import XCTest
import EarlGrey
import ownCloudSDK
import ownCloudMocking
import LocalAuthentication

class LoginTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		super.tearDown()
	}

	// MARK: - Add Server

	func testAddServer() {

		// Enter on server
		EarlGrey.select(elementWithMatcher: grey_accessibilityID("addServer")).perform(grey_tap())
		EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-url-url")).perform(grey_tap()).perform(grey_replaceText("http://www.google.com/"))
		
		OCMockManager.shared.addMockingBlocks([OCMockLocationConectionPrepareForSetup : {
			print("Testing!")
		}])

		//OCMockLocationAuthenticationMethodDetectAuthenticationMethodSupportForConnection

		EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-continue-continue")).perform(grey_tap())

		// Asserts
		//EarlGrey.select(elementWithMatcher: grey_accessibilityID("cancel")).perform(grey_tap())
		//EarlGrey.select(elementWithMatcher: grey_accessibilityID("addServer")).assert(grey_sufficientlyVisible())
	}

}



























