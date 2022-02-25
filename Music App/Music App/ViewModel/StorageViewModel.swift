//
//  StorageViewModel.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-24.
//

import SwiftUI
import CoreData

enum InfoViewMode: CaseIterable, Identifiable {
    case memory
    case fileSystem
    
    var title: String {
        switch self {
        case .memory:
            return "Memory"
        case .fileSystem:
            return "Filesystem"
        }
    }
    
    var id: InfoViewMode { self }
}

class StorageViewModel: ObservableObject {
    
    @Published var fileSystemMusic: [MusicDetails] = []
    
    init() {
        getFromFile()
    }
    
    // Functions for Memory mode
    
    func saveToMemoryStorage(music: Music, musicDetails: MusicDetails, context: NSManagedObjectContext){
        let newMusic = MusicData(context: context)
        newMusic.musicCategory = music.musicCategory
        
        let newMusicDetails = MusicDetailsData(context: context)
        newMusicDetails.name = musicDetails.name
        newMusicDetails.artist = musicDetails.artist
        newMusicDetails.duration = musicDetails.duration
        newMusicDetails.size = musicDetails.size
        
        PersistenceController.shared.save()
    }
    
    func itemExistsInStorage(_ name: String, context: NSManagedObjectContext) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MusicDetailsData")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        return ((try? context.count(for: fetchRequest)) ?? 0) > 0
    }
    
    // Functions for Filesystem mode
    
    func itemExistsInFile(_ name: String) -> Bool {
        return fileSystemMusic.contains(where: { $0.name == name })
    }
    
    func addMusicForFileStoring(musicDetails: MusicDetails) {
        if !fileSystemMusic.contains(where: { $0 == musicDetails }) {
            fileSystemMusic.append(musicDetails)
        }
    }
    
    func getFromFile() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        let fileUrl = url.appendingPathComponent("storedMusic.json").path
       
        if FileManager.default.fileExists(atPath: fileUrl) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: fileUrl))
                let musicDetails = try JSONDecoder().decode([MusicDetails].self, from: data)
                fileSystemMusic = musicDetails
            } catch {
                print(error)
            }
        } else {
            print("JSON file doesn't exists")
        }
    }
    
    func saveToFile() {
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectoryUrl.appendingPathComponent("storedMusic.json")
        do {
            let data = try JSONEncoder().encode(fileSystemMusic)
            fileSystemMusic.removeAll()
            try data.write(to: fileURL, options: [])
        } catch let error as NSError {
           print("Array to JSON conversion failed: \(error.localizedDescription)")
        }
    }
}
