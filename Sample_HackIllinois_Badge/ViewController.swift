//
//  ViewController.swift
//  Sample_HackIllinois_Badge
//
//  Created by Hyosang Ahn on 9/18/19.
//  Copyright © 2019 Hyosang Ahn. All rights reserved.
//

import UIKit

//struct EventResponse:Decodable {
//    var response:Events
//}
//
//struct Events:Decodable {
//    var events:[EventDetail]
//}
//
//
//
//struct EventDetail:Decodable {
//    var name:String
//    var location:EventLocation
//}
//
//
//
//struct EventLocation:Decodable {
//    var latitude:Double
//    var longitude:Double
//}

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var labelLatitude: UILabel!
    @IBOutlet weak var labelLongitude: UILabel!
    
    var eventList = [EventDetail]()
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.labelLatitude
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let info = "Event 2"
//        let eventRequest = EventRequest()
//        eventRequest.getEvents { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let events):
//                self?.eventList = events
//
//            }
//        }
//        self.labelLatitude.text = "\(self.eventList.count)"
//        self.labelLatitude.text = "Latitude: \(self.eventList[1].location.latitude)"
//        self.labelLongitude.text = "Longitude: \(self.eventList[1].location.longitude)"
        
        fetchEventsJSON { (res) in
            switch res {
            case .success(let events):
                DispatchQueue.main.async
                    {self.labelLatitude.text = "Latitude: \(events.events[1].locations[0].latitude)"
                    self.labelLongitude.text = "Longitude: \(events.events[1].locations[0].longitude)"}
            case .failure(let err):
                print("Failed to fetch events: ", err)
            }
        }
    }

    fileprivate func fetchEventsJSON(completion: @escaping (Result<Events, Error>) -> ()) {
        let urlString = "http://api.hackillinois.org/event/"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                let events = try JSONDecoder().decode(Events.self, from: data!)
                completion(.success(events))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
        
        
    }

}

