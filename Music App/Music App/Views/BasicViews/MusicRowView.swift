//
//  MusicRowView.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-25.
//

import SwiftUI

struct MusicRowView: View {
    
    let musicDetails: MusicDetails
    
    var body: some View {
        VStack {
            Text("\(musicDetails.name) - \(musicDetails.artist)")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity,alignment: .leading)
            Text("\(musicDetails.size) - \(musicDetails.duration.intToTimeConverter())")
                .font(.system(size: 10))
                .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}
