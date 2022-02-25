//
//  MusicListView.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-23.
//

import SwiftUI

struct MusicListView: View {
    
    let music: Music
    
    var body: some View {
        VStack {
            Text(music.musicCategory)
                .font(.system(size: 24))
                .padding(.bottom,14)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView {
                ForEach(music.musicDetails, id: \.self) { info in
                    MusicRowView(musicDetails: info)
                      
                    Divider()
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}
