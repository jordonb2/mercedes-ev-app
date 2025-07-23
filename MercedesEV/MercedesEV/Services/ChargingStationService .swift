//
//  ChargingStationService .swift
//  MercedesEV
//
//  Created by Jordon Bowen on 7/23/25.
//

import Foundation

protocol ChargingStationServiceProtocol {
    func fetchStations(latitude: Double, longitude: Double, completion: @escaping (Result<[ChargingStation], Error>) -> Void)
}

class ChargingStationService: ChargingStationServiceProtocol {
    func fetchStations(latitude: Double, longitude: Double, completion: @escaping (Result<[ChargingStation], Error>) -> Void) {
        let urlString = "https://api.openchargemap.io/v3/poi/?output=json&latitude=\(latitude)&longitude=\(longitude)&maxresults=20&compact=true&verbose=false&key=c306c1d5-5b86-4a65-9513-869b37175d8"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let stations = try JSONDecoder().decode([ChargingStation].self, from: data)
                completion(.success(stations))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
