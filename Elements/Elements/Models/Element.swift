//
//  Element.swift
//  Elements
//
//  Created by Kelby Mittan on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    
    let name: String
    let appearance: String?
    let atomicMass: Double
    let boil: Double?
    let category: String
    let discoveredBy: String?
    let melt: Double?
    let summary: String
    let number: Int
    let period: Int
    let symbol: String
    let favoritedBy: String?
    let molarHeat: Double?
    let phase: String
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case appearance
        case atomicMass = "atomic_mass"
        case boil
        case category
        case discoveredBy = "discovered_by"
        case melt
        case summary
        case number
        case period
        case symbol
        case favoritedBy
        case molarHeat = "molar_heat"
        case phase
        case source
    }
    
    
}
