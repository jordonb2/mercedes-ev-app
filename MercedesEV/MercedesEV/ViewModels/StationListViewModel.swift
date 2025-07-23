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

    init(service: ChargingStationServiceProtocol) {
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
