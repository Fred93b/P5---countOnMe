//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import P5_01_Xcode

class CalculatorTestCase: XCTestCase {
    // MARK: - Properties
    var calculator: Calculator!
    let operators = ["+", "-", "*", "/"]
    // MARK: - Methods
    override func setUp() {
        super.setUp()
        calculator = Calculator(textViewModel: "")
    }
    // MARK: - Test elements and correct expression
    func testGivenResultIsZero_WhenTappedNumberButtonOne_ThenScreenTextShouldBeOne() {
        calculator.textViewModel = "0"
        calculator.addNumberForCalculate(number: "1")
        XCTAssertTrue(calculator.textViewModel == "1")
    }
    func testGivenAddNumberOne_WhenTappedOperatorButton_ThenScreenTextShouldBeUpdatedWithNewOperator() {
        calculator.addNumberForCalculate(number: "1")
        XCTAssertTrue(calculator.addOpertorForCalculate(operators: "+"))
        XCTAssertTrue(calculator.textViewModel.contains("1 +"))
        print(calculator.textViewModel)
    }
    func testGivenExpressionIsCorrect_WhenTappedEqualButton_ThenResultShouldBeDisplayed() {
        calculator.textViewModel = "1 + 1"
        XCTAssertTrue(calculator.makeCalculation().validity)
        XCTAssertTrue(calculator.textViewModel.contains("= 2"))
    }
    func testGivenResultIsDisplayed_WhenTappedEqualButton_ThenScreenTextShoulBeUpdateWithResult() {
        calculator.textViewModel = "1 + 1 = 2"
        XCTAssertTrue(calculator.makeCalculation().validity)
        XCTAssert(calculator.textViewModel == "2")
    }
    // MARK: - Tests results calculation
    func testGivenCalculationIsSixAddedByThree_WhenTappedEqualButton_ThenResultShouldBeNine() {
        calculator.textViewModel = "6 + 3"
        XCTAssertTrue(calculator.makeCalculation().validity)
        XCTAssertTrue(calculator.textViewModel.contains("= 9"))
        print(calculator.textViewModel)
    }
    func testGivenCalculationIsSixSubstractByThree_WhenTappedEqualButton_ThenResultShouldBeThree() {
        calculator.textViewModel = "6 - 3"
        XCTAssertTrue(calculator.makeCalculation().validity)
        XCTAssertTrue(calculator.textViewModel.contains("= 3"))
        print(calculator.textViewModel)
    }

    func testGivenCalculationIsSixMultipliedByThree_WhenTappedEqualButton_ThenResultShouldBeEighteen() {
        calculator.textViewModel = "6 * 3"
        XCTAssertTrue(calculator.makeCalculation().validity)
        XCTAssertTrue(calculator.textViewModel.contains("= 18"))
        print(calculator.textViewModel)
    }

    func testGivenCalculationIsSixDividedByThree_WhenTappedEqualButton_ThenResultShouldBeTwo() {
        calculator.textViewModel = "6 / 3"
        XCTAssertTrue(calculator.makeCalculation().validity)
        XCTAssertTrue(calculator.textViewModel.contains("= 2"))
        print(calculator.textViewModel)
    }
    /// gestion des calculs prioritaires concernant les opérateurs * et /
    func testGivenComplexCalculWithAllOperators_WhenTappedEqualButton_ThenResultShouldBeTwo() {
        calculator.textViewModel = "2 + 2 - 2 * 2 / 2"
        XCTAssertTrue(calculator.makeCalculation().validity)
        XCTAssertTrue(calculator.textViewModel.contains("= 2"))
        print(calculator.textViewModel)
    }
    // MARK: - Tests operators errors
    func testGivenNoOperation_WhenTappedEqualButtonForCalculate_ThenAlertShoulBeDisplayedAndNoTextChange() {
        calculator.textViewModel = "0"
        XCTAssertFalse(calculator.makeCalculation().validity, calculator.makeCalculation().message)
        XCTAssert(calculator.textViewModel == "0")
    }
    func testGivenLastElementIsAnOperator_WhenTappedEqualButton_ThenAlertShouldBeDisplayedAndNoTextChange() {
        calculator.textViewModel = "1 +"
        XCTAssertFalse(calculator.makeCalculation().validity, calculator.makeCalculation().message)
        XCTAssert(calculator.textViewModel == "1 +")
    }
    func testGivenLastElementIsAnOperator_WhenAddNewOperator_ThenAlertShoulBeDisplayedAndNoTextChange() {
        calculator.textViewModel = "1 +"
        for operators in operators {
             XCTAssertFalse(calculator.addOpertorForCalculate(operators: operators))
        }
        XCTAssertFalse(calculator.makeCalculation().validity, calculator.makeCalculation().message)
        XCTAssert(calculator.textViewModel == "1 +")
    }
    // MARK: - Tests calculs errors
    /// gestion du bug d'un ajout possible d'un opérateur en première élément (uniquement au démarrage)
    func testGivenWrongOperationWithFirstElementIsOperator_WhenCalculateTotal_ThenTextIsReset() {
        calculator.textViewModel = "+ 1 - 1"
        XCTAssertFalse(calculator.makeCalculation().validity, calculator.makeCalculation().message)
        XCTAssert(calculator.textViewModel == "0")
    }
    /// gestion du bug de la division par zéro
    func testGivenOneDivisionZero_WhenCalculate_ThenAlertShoudlBeDisplayedAndTextIsReset() {
    calculator.textViewModel = "1 / 0"
    XCTAssertFalse(calculator.makeCalculation().validity, calculator.makeCalculation().message)
    XCTAssertTrue(calculator.textViewModel == "0")
    }
    // MARK: - Tests reset
    func testGivenResultIsDisplayed_WhenTappedResetButton_ThenScreenTextShouldBeEqualToZero() {
        calculator.reset()
        XCTAssertTrue(calculator.textViewModel == "0")
    }
}
