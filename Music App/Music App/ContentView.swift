//
//  ContentView.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-21.
//

import SwiftUI

struct ContentView: View {

    private let musicData = ReadMainMusicData()
   
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    MusicBoxView(musicData: musicData)
                    
                    StorageView(musicData: musicData)
                    
                    Spacer()
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
