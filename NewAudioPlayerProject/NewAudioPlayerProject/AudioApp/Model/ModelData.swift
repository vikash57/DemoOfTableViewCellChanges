//
//  ModelData.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 22/06/23.
//

import Foundation

struct ModelData: Codable {
    var music: [Music]
}

// MARK: - Music
struct Music: Codable {
    var isExpanded: Bool
    var titleName, describtion, img, trackName: String
}
