//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 23.04.2024.
//

import Foundation

/// Represents unique API endpoint
enum RMEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}
