//
//  Reactive.swift
//  Pods
//
//  Created by George Kaimakas on 29/03/2017.
//
//

import Foundation

public final class Reactive<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}
