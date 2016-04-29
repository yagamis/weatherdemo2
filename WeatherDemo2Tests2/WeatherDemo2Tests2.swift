//
//  WeatherDemo2Tests2.swift
//  WeatherDemo2Tests2
//
//  Created by 小波 on 16/4/25.
//  Copyright © 2016年 xiaobo. All rights reserved.
//

import XCTest
@testable import WeatherDemo2

class WeatherDemo2Tests2: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNetworkHelper() {
        let bjWeeklyWeather = NetworkHelper.WeeklyWeather(cityid: "1")
        
        let exp = expectationWithDescription("get weekly weather")

        bjWeeklyWeather.getWeather { (results, error) in
            let result = results?.first
            exp.fulfill()
         
            XCTAssertNil(result, "结果为空，应该是网络错误")
            XCTAssert(results!.count == 7)
        }
 
        waitForExpectationsWithTimeout(5) { (e) in
            print("网络错误")
        }
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
