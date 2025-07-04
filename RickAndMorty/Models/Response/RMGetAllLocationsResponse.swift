//
//  RMGetAllLocationsResponse.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 24.04.2024.
//

import Foundation
struct RMGetAllLocationsResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [RMLocation]
}
