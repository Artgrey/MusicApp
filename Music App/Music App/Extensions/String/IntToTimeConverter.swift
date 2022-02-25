//
//  IntToTimeConverter.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-24.
//

import SwiftUI

public extension Int64 {
    
    func intToTimeConverter() -> String {
        let (m, s) = ((self % 3600) / 60, (self % 3600) % 60)
        return "\(m)m \(s)s"
    }
}
