//
//  StorageView.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-24.
//

import SwiftUI

struct StorageView: View {
    
    let musicData: ReadMainMusicData
    @Environment(\.scenePhase) private var scenePhase
    private let storageViewModel = StorageViewModel()
    
    var body: some View {
        VStack {
            headerView
            ForEach(InfoViewMode.allCases) { mode in
                StorageItemView(mode: mode, musicData: musicData, storageViewModel: storageViewModel)
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background && !storageViewModel.fileSystemMusic.isEmpty {
                storageViewModel.saveToFile()
            } else if phase == .active && storageViewModel.fileSystemMusic.isEmpty {
                storageViewModel.getFromFile()
            }
        }
    }
    
    var headerView: some View {
        Text("Storage")
            .font(.system(size: 24))
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct StorageItemView: View {
    
    let mode: InfoViewMode
    let musicData: ReadMainMusicData
    @ObservedObject var storageViewModel = StorageViewModel()
    @FetchRequest(entity: MusicDetailsData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MusicDetailsData.name, ascending: true)])
    
    private var musicFromMemory: FetchedResults<MusicDetailsData>
    
    private var totalDuration: String {
        switch mode {
        case .memory:
            return musicFromMemory.reduce(0) { $0 + $1.duration }.intToTimeConverter()
        case .fileSystem:
            return storageViewModel.fileSystemMusic.compactMap{ $0.duration }.reduce(0, +).intToTimeConverter()
        }
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: StorageListView(music: musicData.music, infoViewMode: mode, storageViewModel: storageViewModel)) {
                HStack {
                    Text(mode.title)
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    switch mode {
                    case .memory:
                        Text(musicFromMemory.count == 0 ? "0m 0s" : totalDuration)
                    case .fileSystem:
                        Text(storageViewModel.fileSystemMusic.count == 0 ? "0m 0s" : totalDuration)
                    }
                
                    Image("right-arrow")
                        .makeIcon()
                }
            }
            .font(.system(size: 14))
            .foregroundColor(.black)
            
            Divider()
        }
    }
}
