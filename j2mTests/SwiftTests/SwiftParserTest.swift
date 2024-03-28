//
//  SwiftParserTest.swift
//  j2mTests
//
//  Created by Revan Sadigli on 28.03.2024.
//

import XCTest
@testable import j2m

final class SwiftParserTest: XCTestCase {

    func testPerformanceOfConvertToSwiftModelPerformance() throws {
        measure {
            testConvertToSwiftModel()
        }
    }
    
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
        
        let parser = SwiftJsonParser(rawJsonText: rawJsonText, enumCodingKeysOption: true, varOrLet: true, isPropertiesOptional: true)
        
        // When
        parser.convertToSwiftModel(structName: "Welcome")

        XCTAssertEqual(expectedStructCount, parser.structsArray.count)
    }
    
    func testGeneratePropertiesCodeForString() {
        // Given
        let parser = SwiftJsonParser(rawJsonText: "", enumCodingKeysOption: false, varOrLet: true, isPropertiesOptional: true)
        let dictionary: [String: Any] = ["key": "value"]
        
        // When
        let propertiesCode = parser.generatePropertiesCode(from: dictionary)
        
        // Then
        XCTAssertEqual(propertiesCode, "    var key: String?\n")
    }
    
    func testGeneratePropertiesCodeForInt() {
        // Given
        let parser = SwiftJsonParser(rawJsonText: "", enumCodingKeysOption: false, varOrLet: true, isPropertiesOptional: true)
        let dictionary: [String: Any] = ["key": 123]
        
        // When
        let propertiesCode = parser.generatePropertiesCode(from: dictionary)
        
        // Then
        XCTAssertEqual(propertiesCode, "    var key: Int?\n")
    }

}
