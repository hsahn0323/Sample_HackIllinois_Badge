//
//  APIRequester.swift
//  Sample_HackIllinois_Badge
//
//  Created by Hyosang Ahn on 9/20/19.
//  Copyright © 2019 Hyosang Ahn. All rights reserved.
//

import Foundation

enum EventError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct EventRequest {
    let resourceURL:URL
    let API_KEY = ""
    
    init() {
//        let date = Date()
//        let format = DateFormatter()
//        format.dateFormat = "yyyy"
//        let currentYear = format.string(from: date)
        
        let resourceString = "http://api.hackillinois.org/event/"
        
        guard let resourceURL = URL(string:resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getEvents (completion: @escaping(Result<[EventDetail], EventError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let eventsResponse = try decoder.decode(EventResponse.self, from:jsonData)
                let eventDetails = eventsResponse.response.events
                completion(.success(eventDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
