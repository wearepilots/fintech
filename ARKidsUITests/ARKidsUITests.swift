//
//  ARKidsUITests.swift
//  ARKidsUITests
//
//  Created by a.shchepakin on 25.01.2021.
//  Copyright © 2021 Victor Sobolev. All rights reserved.
//

import XCTest

class ARKidsUITests: XCTestCase {

    func testCaseOne() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.tables/*@START_MENU_TOKEN@*/.staticTexts["Doctor"]/*[[".cells.staticTexts[\"Doctor\"]",".staticTexts[\"Doctor\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Doctor"]/*[[".cells.staticTexts[\"Doctor\"]",".staticTexts[\"Doctor\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.navigationBars["Profile"].buttons["Back"].exists)
        app.navigationBars["Profile"].buttons["Back"].tap()
        }

    
            }
        
