//
//  ownCloudTests.swift
//  ownCloudTests
//
//  Created by Pablo Carrascal on 07/03/2018.
//  Copyright © 2018 ownCloud. All rights reserved.
//

import XCTest
import EarlGrey

@testable import ownCloud

class OwnCloudTests: XCTestCase {
    
    let demoServer: String = "demo.owncloud.org"
    let username : String = "demo"
    let password : String = "demo"
    let nameServer : String = "demo"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*
     * Passed if: "Add Server" button is enabled
     */
    func test1AddServerButtonIsEnabled() {
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("addServer")).assert(with: grey_enabled())
    }
    
    /*
     * Passed if: Empty URL error shows correct message
     */
    func test2EmptyURL() {
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("addServer")).perform(grey_tap())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-continue-continue")).perform(grey_tap())
        
        //Asserts
        
        EarlGrey.select(elementWithMatcher: grey_text("Missing hostname")).assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_text("OK")).perform(grey_tap())
    }
    
    /*
     * Passed if: Wrong URL error shows correct message
     */
    func test3WrongURL() {
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-url-url")).perform(grey_replaceText("WrongURL"))
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-continue-continue")).perform(grey_tap())
        
        //Asserts
        
        EarlGrey.select(elementWithMatcher: grey_text("OK")).perform(grey_tap())
    }
    
    /*
     * Passed if: Credentials: username, password, server name, and certificate are displayed if connection works to basic auth server
     */
    
    func test4CorrectURLShowFields() {
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-url-url")).perform(grey_replaceText(demoServer))
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-continue-continue")).perform(grey_tap())
        
        //Asserts
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-credentials-username")).assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-credentials-password")).assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-url-certificate")).assert(grey_sufficientlyVisible())
        
    }
    
    /*
     * Passed if: Username and password hints are visible (we remain in the same view)
     */
    func test5EmptyCredentials() {
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-continue-continue")).perform(grey_tap())
        
        //Asserts
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Username")).assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Password")).assert(grey_sufficientlyVisible())
        
    }
    
    /*
     * Passed if: Username and password hints are visible (user remains in the same view because credentials error)
     */
    func test6CorrectLogin() {
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-name-name")).perform(grey_replaceText(nameServer))
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-credentials-username")).perform(grey_replaceText(username))
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-credentials-password")).perform(grey_replaceText(password))
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("row-continue-continue")).perform(grey_tap())
        
        //Asserts
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Username")).assert(grey_notVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Password")).assert(grey_notVisible())
        EarlGrey.select(elementWithMatcher: grey_text(nameServer)).assert(grey_sufficientlyVisible())
        
    }
    
    /*
     * Passed if: Bookmark is not deleted after cancelling the confirmation
     */
    func test7CancelDeleteBookmark() {
        
        EarlGrey.select(elementWithMatcher: grey_text(nameServer)).perform(grey_swipeFastInDirection(GREYDirection.left))
        EarlGrey.select(elementWithMatcher: grey_text("Delete")).perform(grey_tap())
        EarlGrey.select(elementWithMatcher: grey_text("Cancel")).perform(grey_tap())
        
        //Asserts
        
        EarlGrey.select(elementWithMatcher: grey_text(nameServer)).assert(grey_sufficientlyVisible())
        
    }
    
    /*
     * Passed if: Bookmark is deleted, so welcome view to add server is displayed with the "Add Button" enabled
     */
    func test8DeleteBookmark() {
        
        EarlGrey.select(elementWithMatcher: grey_text(nameServer)).perform(grey_swipeFastInDirection(GREYDirection.left))
        EarlGrey.select(elementWithMatcher: grey_text("Delete")).perform(grey_tap())
        EarlGrey.select(elementWithMatcher: grey_text("Delete")).perform(grey_tap())
        
        //Asserts
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("addServer")).assert(grey_enabled())
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
