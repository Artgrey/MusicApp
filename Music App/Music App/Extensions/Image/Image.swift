//
//  Image.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-22.
//

import SwiftUI

public extension Image {
    
    func makeIcon(height: CGFloat = 16) -> some View {
        self
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(height: height)
    }
}
