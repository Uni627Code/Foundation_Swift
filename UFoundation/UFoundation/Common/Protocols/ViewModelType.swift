//
//  ViewModelType.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}
