//
//  DurationStringTests.swift
//  ScottishPowerTestTests
//
//  Created by Stephen on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import XCTest
@testable import ScottishPowerTest

class DurationStringTests: XCTestCase {
    
    func testZeroMinutes() {
        let string = DurationStringHelper.durationString(milliseconds: 1 * 50 * 1000)
        XCTAssertEqual(string, "0 minutes 50 seconds")
    }
    
    func testOneMinute() {
        let string = DurationStringHelper.durationString(milliseconds: 1 * 60 * 1000)
        XCTAssertEqual(string, "1 minute 0 seconds")
    }
    
    func testMultipleMinutes() {
        let string = DurationStringHelper.durationString(milliseconds: 23 * 60 * 1000)
        XCTAssertEqual(string, "23 minutes 0 seconds")
    }
    
    func testZeroSeconds() {
        let string = DurationStringHelper.durationString(milliseconds: 100)
        XCTAssertEqual(string, "0 minutes 0 seconds")
    }
    
    func testMultipleSeconds() {
        let string = DurationStringHelper.durationString(milliseconds: 8 * 1000)
        XCTAssertEqual(string, "0 minutes 8 seconds")
    }
    
    func testOneSecond() {
        let string = DurationStringHelper.durationString(milliseconds: 1000)
        XCTAssertEqual(string, "0 minutes 1 second")
    }
    
    //Kind of redundant because the other tests don't have hours either, but in the interest of completeness...
    func testZeroHours() {
        let string = DurationStringHelper.durationString(milliseconds: 100)
        XCTAssertEqual(string, "0 minutes 0 seconds")
    }
    
    func testOneHour() {
        let string = DurationStringHelper.durationString(milliseconds: 60 * 60 * 1000)
        XCTAssertEqual(string, "1 hour 0 minutes 0 seconds")
    }
    
    func testMultipleHours() {
        let string = DurationStringHelper.durationString(milliseconds: 2 * 60 * 60 * 1000 + 23 * 60 * 1000 + 20 * 1000)
        XCTAssertEqual(string, "2 hours 23 minutes 20 seconds")
    }
}
