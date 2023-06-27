//
//  DescriptionData.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 26/06/23.
//

import Foundation

struct DescriptionData: Codable {
    var playList: [PlayList]

    enum CodingKeys: String, CodingKey {
        case playList = "PlayList"
    }
}

// MARK: - PlayList
struct PlayList: Codable {
    var titleName: String
    var musicList: [MusicList]
}

// MARK: - MusicList
struct MusicList: Codable {
    var isExpanded: Bool
    var titleName, describtion, img, trackName: String
}
