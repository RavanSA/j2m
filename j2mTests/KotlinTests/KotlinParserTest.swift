//
//  KotlinParserTest.swift
//  j2mTests
//
//  Created by Revan Sadigli on 28.03.2024.
//

import XCTest
@testable import j2m

class KotlinJsonParserTests: XCTestCase {

    func testGeneratePropertiesCodeForString() {
        // Given
        let parser = KotlinJsonParser(rawJsonText: "")
        let dictionary: [String: Any] = ["key": "value"]
        
        // When
        let propertiesCode = parser.generatePropertiesCode(from: dictionary)
        
        // Then
        XCTAssertEqual(propertiesCode, "    val key: String?\n")
    }
    
    func testGeneratePropertiesCodeForInt() {
        // Given
        let parser = KotlinJsonParser(rawJsonText: "")
        let dictionary: [String: Any] = ["key": 123]
        
        // When
        let propertiesCode = parser.generatePropertiesCode(from: dictionary)
        
        // Then
        XCTAssertEqual(propertiesCode, "    val key: Int?\n")
    }
    
    func testGenerateDataClassForString() {
        func testConvertToSwiftModel() {
            // Given
            let rawJsonText = """
            {
              "university": "University A",
              "courses": [
                {
                  "department": "Computer Science",
                  "courseList": [
                    {
                      "courseCode": "CS101",
                      "courseName": "Introduction to Computer Science",
                      "credits": 3
                    },
                    {
                      "courseCode": "CS201",
                      "courseName": "Data Structures and Algorithms",
                      "credits": 4
                    }
                  ]
                },
                {
                  "department": "Mathematics",
                  "courseList": [
                    {
                      "courseCode": "MATH101",
                      "courseName": "Calculus I",
                      "credits": 4
                    },
                    {
                      "courseCode": "MATH202",
                      "courseName": "Linear Algebra",
                      "credits": 3
                    }
                  ]
                }
              ]
            }
            """
            
            let expectedStructCount = 3
            
            let parser = KotlinJsonParser(rawJsonText: rawJsonText)
            
            // When
            parser.convertToKotlinDataClass()

            XCTAssertEqual(expectedStructCount, parser.dataClassArray.count)
        }
    }
    
}
