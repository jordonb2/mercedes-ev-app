//
//  StationListViewModel.swift
//  MercedesEV
//
//  Created by Jordon Bowen on 7/23/25.
//

import Foundation
import Combine

class StationListViewModel: ObservableObject {
    @Published var stations: [ChargingStation] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private let service: ChargingStationServiceProtocol

    // MARK: - Connection Type Mapping
    let connectionTypeLookup: [Int: String] = [
        1: "Type 1 (J1772)",
        2: "Type 2 (Mennekes)",
        3: "CHAdeMO",
        4: "CCS Combo 1",
        5: "CCS Combo 2",
        32: "Tesla Supercharger"
    ]

    init(service: ChargingStationServiceProtocol = ChargingStationService()) {
        self.service = service
    }

    func fetchNearbyStations(lat: Double, lon: Double) {
        isLoading = true
        service.fetchStations(latitude: lat, longitude: lon) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let stations):
                    self?.stations = stations
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
