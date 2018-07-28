//
//  TaggingExampleUITests.swift
//  TaggingExampleUITests
//
//  Created by DongHeeKang on 2018. 7. 17..
//  Copyright © 2018년 k-lpmg. All rights reserved.
//

import XCTest

class TaggingExampleUITests: XCTestCase {
    
    var app: XCUIApplication!
    var tagging: AnyObject!
    var taggingTextView: AnyObject!
    var tagableTableView: AnyObject!
    var taggedTableView: AnyObject!
    
    let deleteString = XCUIKeyboardKey.delete.rawValue
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        tagging = app.otherElements["Tagging"]
        taggingTextView = tagging.textViews["TaggingTextView"]
        tagableTableView = app.tables["TagableTableView"]
        taggedTableView = app.tables["TaggedTableView"]
        
        XCTAssertTrue(tagging.exists)
        XCTAssertTrue(tagableTableView.exists)
        XCTAssertTrue(taggedTableView.exists)
        XCTAssertTrue(taggingTextView.exists)
    }
    
    func testSingleAdd() {
        taggingTextView.tap()
        taggingTextView.typeText("Hello ")
        taggingTextView.typeText("#TRA")
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 1)
    }
    
    func testMultipleAdd() {
        taggingTextView.tap()
        taggingTextView.typeText("Hello ")
        taggingTextView.typeText("#TRA")
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 1)
        
        taggingTextView.typeText("#SOL")
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 2)
    }
    
    func testSingleDelete() {
        taggingTextView.tap()
        taggingTextView.typeText("Hello ")
        taggingTextView.typeText("#TRA")
        XCTAssertEqual(taggedTableView.cells.count, 0)
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 1)
        
        taggingTextView.typeText(deleteString)
        taggingTextView.typeText(deleteString)
        
        XCTAssertEqual(taggedTableView.cells.count, 0)
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 1)
    }
    
    func testMultipleDelete() {
        taggingTextView.tap()
        taggingTextView.typeText("Hello ")
        taggingTextView.typeText("#TRA")
        XCTAssertEqual(taggedTableView.cells.count, 0)
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 1)
        
        taggingTextView.typeText("#SOL")
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 2)
        
        taggingTextView.typeText(deleteString)
        taggingTextView.typeText(deleteString)
        
        XCTAssertEqual(taggedTableView.cells.count, 1)
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 2)
    }
    
    func testMiddleInsertion() {
        taggingTextView.tap()
        taggingTextView.typeText("#TRA")
        XCTAssertEqual(taggedTableView.cells.count, 0)
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 1)
        
        taggingTextView.typeText("#SOL")
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 2)
        
        taggingTextView.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0)).tap()
        taggingTextView.typeText("MER")
        XCTAssertEqual(taggedTableView.cells.count, 1)
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 2)
    }
    
    func testEnter() {
        taggingTextView.tap()
        taggingTextView.typeText("#TRA")
        XCTAssertEqual(taggedTableView.cells.count, 0)
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 1)
        
        taggingTextView.typeText("#SOL")
        
        tagableTableView.cells.element(boundBy: 0).tap()
        XCTAssertEqual(taggedTableView.cells.count, 2)
        
        taggingTextView.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0)).tap()
        taggingTextView.typeText("\n")
        taggingTextView.typeText("\n")
        XCTAssertEqual(taggedTableView.cells.count, 1)
    }
    
}
