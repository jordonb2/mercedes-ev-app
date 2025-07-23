//
//  MercedesEVApp.swift
//  MercedesEV
//
//  Created by Jordon Bowen on 7/23/25.
//

import SwiftUI

@main
struct MercedesEVApp: App {
    var body: some Scene {
        WindowGroup {
            let service = ChargingStationService()
            let viewModel = StationListViewModel(service: service)
            StationListView(viewModel: viewModel)
        }
    }
}
