//
//  StationDetailViewModel.swift
//  MercedesEV
//
//  Created by Jordon Bowen on 7/24/25.
//

import Foundation

final class StationDetailViewModel: ObservableObject {
    private let station: ChargingStation

    init(station: ChargingStation) {
        self.station = station
    }

    var title: String {
        station.addressInfo.title ?? "Unnamed Station"
    }

    var address: String {
        let info = station.addressInfo
        return [info.addressLine1, info.town, info.stateOrProvince, info.postcode]
            .compactMap { $0 }
            .joined(separator: ", ")
    }

    var usageType: String {
        station.usageType?.title ?? "Unknown"
    }

    var connectionTypes: [String] {
        let rawConnections = station.connections ?? []
        
        let types = rawConnections.compactMap { connectionTitle(from: $0.connectionTypeID) }
        
        return types.isEmpty ? ["No connections available"] : types
    }
    
    var accessComments: String {
        station.addressInfo.accessComments ?? ""
    }
    
    private func connectionTitle(from id: Int?) -> String {
        guard let id = id else { return "Unknown" }
        switch id {
        case 1: return "Type 1 (J1772)"
        case 2: return "Type 2 (Mennekes)"
        case 3: return "CHAdeMO"
        case 32: return "CCS Combo"
            // Add more as needed based on OpenChargeMap documentation
        default: return "Unknown Type"
        }
    }
    
    var latitude: Double? {
        station.addressInfo.latitude
    }

    var longitude: Double? {
        station.addressInfo.longitude
    }
}
