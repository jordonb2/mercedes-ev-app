//
//  StationDetailView.swift
//  MercedesEV
//
//  Created by Jordon Bowen on 7/24/25.
//

import SwiftUI

struct StationDetailView: View {
    let viewModel: StationDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.title)
                .font(.title)
                .fontWeight(.bold)

            if !viewModel.address.isEmpty {
                Text(viewModel.address)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            if !viewModel.usageType.isEmpty {
                Text("Usage: \(viewModel.usageType)")
                    .font(.subheadline)
            }

            if !viewModel.connectionTypes.isEmpty {
                Text("Connection Types:")
                    .font(.headline)
                ForEach(viewModel.connectionTypes, id: \.self) { type in
                    Text("• \(type)")
                        .font(.subheadline)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Station Details")
    }
}
