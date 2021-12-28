//
//  Stubbable.swift
//  Domain
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import Foundation

public protocol Stubbable {
    static var stub: Self { get }
}
