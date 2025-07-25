//
//  MercedesEVTests.swift
//  MercedesEVTests
//
//  Created by Jordon Bowen on 7/25/25.
//

import Testing
import XCTest
@testable import MercedesEV

final class StationDetailViewModelTests: XCTestCase {
    func testConnectionTypesMapping() {
        // Arrange: create a fake station with known connectionTypeIDs
        let mockConnections = [
            Connection(connectionTypeID: 1),  // Should map to "Type 1 (J1772)"
            Connection(connectionTypeID: 2),  // Should map to "Type 2 (Mennekes)"
            Connection(connectionTypeID: 99)  // Should map to "Unknown Type"
        ]
        
        let station = ChargingStation(
            id: 1,
            addressInfo: AddressInfo(
                title: "Test Station",
                addressLine1: "123 Test St",
                town: "Testville",
                stateOrProvince: "TS",
                postcode: "12345",
                latitude: 0.0,
                longitude: 0.0,
                accessComments: "Open 24/7"
            ),
            connections: mockConnections,
            usageType: nil
        )
        
        // Act
        let viewModel = StationDetailViewModel(station: station)
        
        // Assert
        XCTAssertEqual(viewModel.connectionTypes.count, 3)
        XCTAssertEqual(viewModel.connectionTypes[0], "Type 1 (J1772)")
        XCTAssertEqual(viewModel.connectionTypes[1], "Type 2 (Mennekes)")
        XCTAssertEqual(viewModel.connectionTypes[2], "Unknown Type")
    }
}

final class StationListViewModelTests: XCTestCase {
    func testFetchNearbyStations_success() {
        // Arrange
        let mockService = MockChargingStationService()
        mockService.shouldReturnError = false
        let viewModel = StationListViewModel(service: mockService)
        
        // Act
        viewModel.fetchNearbyStations(lat: 0.0, lon: 0.0)
        
        // Wait briefly for async dispatch to complete
        let expectation = XCTestExpectation(description: "Wait for async call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Assert
            XCTAssertEqual(viewModel.stations.count, 1)
            XCTAssertEqual(viewModel.stations.first?.id, 1)
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchNearbyStations_error() {
        // Arrange
        let mockService = MockChargingStationService()
        mockService.shouldReturnError = true
        let viewModel = StationListViewModel(service: mockService)
        
        // Act
        viewModel.fetchNearbyStations(lat: 0.0, lon: 0.0)
        
        // Wait briefly for async dispatch to complete
        let expectation = XCTestExpectation(description: "Wait for async error")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.stations.count, 0)
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

