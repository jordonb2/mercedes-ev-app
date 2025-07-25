//
//  ChargingStation.swift
//  MercedesEV
//
//  Created by Jordon Bowen on 7/23/25.
//

import Foundation

// Global lookup for connection type titles
let connectionTypeLookup: [Int: String] = [
    1: "Type 1 (J1772)",
    2: "Type 2 (Mennekes)",
    3: "CHAdeMO",
    4: "CCS Combo 1",
    5: "CCS Combo 2",
    32: "Tesla Supercharger"
]

struct ChargingStation: Decodable, Identifiable {
    let id: Int
    let addressInfo: AddressInfo
    let connections: [Connection]?
    let usageType: UsageType?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case addressInfo = "AddressInfo"
        case connections = "Connections"
        case usageType = "UsageType"
    }

    var connectionTypes: [String] {
        let types: [String] = connections?
            .compactMap { connection in
                if let id = connection.connectionTypeID {
                    return connectionTypeLookup[id]
                }
                return nil
            } ?? []
        
        return types.isEmpty ? ["No connections available"] : types
    }
}

    struct AddressInfo: Decodable {
        let title: String?
        let addressLine1: String?
        let town: String?
        let stateOrProvince: String?
        let postcode: String?
        let latitude: Double?
        let longitude: Double?
        let accessComments: String?
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case addressLine1 = "AddressLine1"
            case town = "Town"
            case stateOrProvince = "StateOrProvince"
            case postcode = "Postcode"
            case latitude = "Latitude"
            case longitude = "Longitude"
            case accessComments = "AccessComments"
        }
    }

    struct Connection: Decodable {
        let connectionTypeID: Int?
        
        enum CodingKeys: String, CodingKey {
            case connectionTypeID = "ConnectionTypeID"
        }
    }

    struct UsageType: Decodable {
        let title: String?
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
        }
    }
