import SwiftUI

struct Music: Codable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case musicDetails = "musicDetails"
        case musicCategory = "musicCategory"
    }
    
    var id = UUID()
    var musicDetails: [MusicDetails]
    var musicCategory: String
}

struct MusicDetails: Codable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case artist = "artist"
        case size = "size"
        case duration = "duration"
    }
    
    var name: String
    var artist: String
    var size: String
    var duration: Int64
}
