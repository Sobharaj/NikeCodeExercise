//
//  Mock.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/13/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import UIKit

/// Use this protocol in the class you want to mock. The methods that you want mocked should use the perfom methods to capture the parameters and mock the answer
protocol Mockable {}

extension Mockable {

    /// - Parameters:
    ///   - _: Mock method that was invoked
    ///   - parameters: Parameters with which the method was called. If there is more than one parameters pass it as a tuple (i.e parameters: (param1, param2)
    func perform(_ mock: Mock, parameters: Any) {
        mock.performClosure?(parameters)
       // mock.invocations.append(parameters)
    }
}

/// Use Mock to mock a method in a Mockable class
final class Mock {
    /// Each item contains the params used in the respective method call
   // var invocations: [Any] = []
    fileprivate var result: Any? {
        didSet {
            valueWasSet = true
        }
    }

    fileprivate var valueWasSet = false
    fileprivate var performClosure: ((Any) -> Void)?


    /// Mock the outcome of the mocked method. Only useful if the Mock is being used in a method that returns
    ///
    /// - Parameter outcome: Value that will be returned in the mock method
    func mockOutcome(_ outcome: Any?) {
        result = outcome
    }

    /// Mock the outcome of the mocked mehtod. This mock is useful if you want to perform something with the params passed to the mocked method
    /// For example you would want a mocked method with a completion to be executed immediately with a mocked result.
    ///
    /// - Parameters:
    ///   - outcome: Value that will be returned in the mock method if necessary. If not just specify void ()
    ///   - closure: Code that will be executed before returning the mocked outcome
    func mockOutcome(_ outcome: Any?, performingWithParams closure: @escaping (Any) -> Void) {
        result = outcome
        performClosure = closure
    }

}
