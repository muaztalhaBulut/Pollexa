//
//  PollexaUITests.swift
//  PollexaUITests
//
//  Created by Eda Bulut on 8.06.2024.
//

import XCTest

final class PollexaUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testPollTableViewCellCollectionViewInteraction() {
        let tableView = app.tables["pollTableView"]
        XCTAssertTrue(tableView.exists, "The table view exists")
        
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "The first cell exists")
        
        let userImageView = firstCell.images["userImageView"]
        XCTAssertTrue(userImageView.exists, "The user image view exists")
        
        let userNameLabel = firstCell.staticTexts["userNameLabel"]
        XCTAssertTrue(userNameLabel.exists, "The user name label exists")
        
        let timeLabel = firstCell.staticTexts["timeLabel"]
        XCTAssertTrue(timeLabel.exists, "The time label exists")
        
        let questionLabel = firstCell.staticTexts["questionLabel"]
        XCTAssertTrue(questionLabel.exists, "The question label exists")
        
        let totalVoteLabel = firstCell.staticTexts["totalVoteLabel"]
        XCTAssertTrue(totalVoteLabel.exists, "The total vote label exists")
        
        let tablesQuery = XCUIApplication().tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 1)
        
        let button = cell.children(matching: .image).element(boundBy: 0)
        XCTAssertTrue(button.exists, "button exists")
        button.tap()
    }
}


