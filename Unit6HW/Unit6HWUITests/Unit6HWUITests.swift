//
//  Unit6HWUITests.swift
//  Unit6HWUITests
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import XCTest

class Unit6HWUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testAddDeck() {
        
        let app = XCUIApplication()
        app.buttons["createNewDeck"].tap()
        app.alerts["Create A New Deck"].collectionViews.textFields["Enter deck name"].typeText("A New Deck")
        app.typeText("\r")
        
    }
    

    func testSignIn() {

        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"Unit6HW.CategoriesView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 2).tap()
        app.buttons["Log In"].tap()

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("test@test.com")

        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("testtest")
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app.buttons["Sign In"].tap()

    }
    
    
//    func testLogIn() {
//
//        let app = XCUIApplication()
//        app.buttons["Log In"].tap()
//
//        let emailTextField = app.textFields["Email"]
//        emailTextField.tap()
//        emailTextField.typeText("test@test.com")
//
//        let passwordSecureTextField = app.secureTextFields["Password"]
//        passwordSecureTextField.tap()
//        passwordSecureTextField.typeText("testtest\r")
//
//    }
    
 
    


    
    
}
