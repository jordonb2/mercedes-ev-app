//
//  StationListView.swift
//  MercedesEV
//
//  Created by Jordon Bowen on 7/23/25.
//

import SwiftUI

struct StationListView: View {
    @ObservedObject var viewModel: StationListViewModel
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView("Loading stations...")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List(viewModel.stations) { station in
                    NavigationLink(
                        destination: StationDetailView(
                            viewModel: StationDetailViewModel(station: station)
                        )
                    ) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(station.addressInfo.title ?? "Unnamed Station")
                                .font(.headline)

                            if let address = station.addressInfo.addressLine1 {
                                Text(address)
                                    .font(.subheadline)
                            }

                            if let town = station.addressInfo.town,
                               let state = station.addressInfo.stateOrProvince {
                                Text("\(town), \(state)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .navigationTitle("EV Charging Stations")
            }
        }
        .onAppear {
            // Replace with real coordinates later or use CoreLocation
            viewModel.fetchNearbyStations(lat: 37.7749, lon: -122.4194) // San Francisco
        }
    }
}
