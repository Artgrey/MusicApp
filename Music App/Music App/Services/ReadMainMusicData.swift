//
//  ReadMainMusicData.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-23.
//

import Foundation

class ReadMainMusicData {
    
    var music: [Music] = []
  
    init(){
        loadMusicData()
    }

    func loadMusicData() {
        guard let url = Bundle.main.url(forResource: "musicMain", withExtension: "json") else {
            fatalError("Json file not found")
        }
       
        do {
            let data = try Data(contentsOf: url)
            let music = try JSONDecoder().decode([Music].self, from: data)
            self.music = music
        } catch {
            print(error)
        }
        
    }
}
