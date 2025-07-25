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
        let connectionType: ConnectionType?
        
        enum CodingKeys: String, CodingKey {
            case connectionType = "ConnectionType"
        }

        struct ConnectionType: Decodable {
            let title: String?
            
            enum CodingKeys: String, CodingKey {
                case title = "Title"
            }
        }
    }

    struct UsageType: Decodable {
        let title: String?
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
        }
    }
}
