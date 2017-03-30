//
//  ReactiveCompatible.swift
//  Pods
//
//  Created by George Kaimakas on 29/03/2017.
//
//

import Foundation

public protocol ReactiveCompatible {
    associatedtype CompatibleType
    
    var reactive: Reactive<CompatibleType> { get }
}

public extension ReactiveCompatible {
    public var reactive: Reactive<Self> {
        return Reactive<Self>(self)
    }
}
