//
//  StorageListView.swift
//  Music App
//
//  Created by Krivenkis on 2022-02-24.
//

import SwiftUI
import CoreData

struct StorageListView: View {
    
    let music: [Music]
    let infoViewMode: InfoViewMode
    let storageViewModel: StorageViewModel
    
    var body: some View {
        VStack {
            Text(infoViewMode.title)
                .font(.system(size: 24))
                .padding(.bottom,14)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView {
                ForEach(music, id:\.id) { music in
                    ForEach(music.musicDetails, id:\.self) { info in
                        StorageItemView(storageViewModel: storageViewModel, music: music, musicDetails: info, infoViewMode: infoViewMode)
                    }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct StorageItemView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var storageViewModel: StorageViewModel
    @State private var isSaved: Bool = false
    
    let music: Music
    let musicDetails: MusicDetails
    let infoViewMode: InfoViewMode
    
    var body: some View {
        HStack {
            MusicRowView(musicDetails: musicDetails)
            
            if isSaved {
                Image("check")
                    .makeIcon(height: 20)
                    .foregroundColor(.blue)
                    .padding(4)
            } else {
                Button(action: {
                    switch infoViewMode {
                    case .memory:
                        storageViewModel.saveToMemoryStorage(music: music, musicDetails: musicDetails, context: managedObjectContext)
                        isSaved = storageViewModel.itemExistsInStorage(musicDetails.name, context: managedObjectContext)
                    case .fileSystem:
                        storageViewModel.addMusicForFileStoring(musicDetails: musicDetails)
                        isSaved = storageViewModel.itemExistsInFile(musicDetails.name)
                    }
                }, label: {
                    Image("floppy-disk")
                        .makeIcon(height: 20)
                        .foregroundColor(.blue)
                        .padding(4)
                })
            }
        }
        .onAppear(perform: {
            switch infoViewMode {
            case .memory:
                isSaved = storageViewModel.itemExistsInStorage(musicDetails.name, context: managedObjectContext)
            case .fileSystem:
                isSaved = storageViewModel.itemExistsInFile(musicDetails.name)
            }
        })
        
        Divider()
    }
}
