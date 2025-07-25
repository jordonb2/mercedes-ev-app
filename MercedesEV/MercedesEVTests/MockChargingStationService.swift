//
//  MockChargingStationService.swift
//  MercedesEV
//
//  Created by Jordon Bowen on 7/25/25.
//

import Foundation
@testable import MercedesEV

// Mock implementation of ChargingStationServiceProtocol for testing
class MockChargingStationService: ChargingStationServiceProtocol {
    var shouldReturnError: Bool = false

    func fetchStations(latitude: Double, longitude: Double, completion: @escaping (Result<[ChargingStation], Error>) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "TestError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error occurred"])
            completion(.failure(error))
        } else {
            let mockStation = ChargingStation(
                id: 1,
                addressInfo: AddressInfo(
                    title: "Test Station",
                    addressLine1: "123 Test St",
                    town: "Testville",
                    stateOrProvince: "TS",
                    postcode: "12345",
                    latitude: 0.0,
                    longitude: 0.0,
                    accessComments: "24/7"
                ),
                connections: [
                    Connection(connectionTypeID: 1),
                    Connection(connectionTypeID: 2)
                ],
                usageType: nil,
            )
            completion(.success([mockStation]))
        }
    }
}
