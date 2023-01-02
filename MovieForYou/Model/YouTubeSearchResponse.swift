//
//  YouTubeSearchResponse.swift
//  MovieForYou
//
//  Created by Dmitryi Velko on 27.12.2022.
//

import Foundation

struct YouTubeSearchResponse: Decodable {
    let items: [VideoElement]
}

struct VideoElement: Decodable {
    let id: IdVideoElement
}

struct IdVideoElement: Decodable {
    let kind: String
    let videoId: String
}
