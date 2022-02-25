//
//  MusicBoxView.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-21.
//

import SwiftUI

struct MusicBoxView: View {
    
    let musicData: ReadMainMusicData
    
    var body: some View {
        VStack {
            ForEach(musicData.music, id:\.id) { music in
                VStack {
                    HeaderView(music: music)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(music.musicDetails.prefix(5), id: \.self) { info in
                                MusicDetailsBoxView(musicDetails: info)
                            }
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).fill(.cyan))
            }
        }
    }
}

private struct HeaderView: View {
    
    let music: Music
    
    var body: some View {
        HStack {
            Text(music.musicCategory)
                .font(.system(size: 24))
            
            Spacer()
            
            NavigationLink(destination: MusicListView(music: music)) {
                Text("See all")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 30)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.purple))
            }
            
        }
    }
}

private struct MusicDetailsBoxView: View {
    
    let musicDetails: MusicDetails
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string:"https://picsum.photos/seed/picsum")) { image in
               image.resizable()
           } placeholder: {
               Image("musicImage")
                   .resizable()
           }
           .frame(height: 80)
           .clipShape(RoundedRectangle(cornerRadius: 5))
           
            Text("\(musicDetails.name) - \(musicDetails.artist)")
                .font(.system(size: 14))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack {
                Text(musicDetails.size)
                   
                Spacer()
                
                Text(musicDetails.duration.intToTimeConverter())
            }
            .font(.system(size: 10))
        }
        .frame(height: 160)
        .frame(maxWidth: 110)
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 5).fill(.blue))
    }
}
