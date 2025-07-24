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
        station.connections?
            .compactMap { $0.connectionType?.title }
            ?? ["No connections available"]
    }

    var latitude: Double? {
        station.addressInfo.latitude
    }

    var longitude: Double? {
        station.addressInfo.longitude
    }
}
