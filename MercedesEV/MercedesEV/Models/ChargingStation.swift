//
//  ChargingStation.swift
//  MercedesEV
//
//  Created by Jordon Bowen on 7/23/25.
//

import Foundation

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

    struct AddressInfo: Decodable {
        let title: String?
        let addressLine1: String?
        let town: String?
        let stateOrProvince: String?
        let postcode: String?
        let latitude: Double?
        let longitude: Double?
    }

    struct Connection: Decodable {
        let connectionType: ConnectionType?

        struct ConnectionType: Decodable {
            let title: String?
        }
    }

    struct UsageType: Decodable {
        let title: String?
    }
}
