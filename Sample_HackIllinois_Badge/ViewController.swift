//
//  ViewController.swift
//  Sample_HackIllinois_Badge
//
//  Created by Hyosang Ahn on 9/18/19.
//  Copyright © 2019 Hyosang Ahn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var labelLatitude: UILabel!
    @IBOutlet weak var labelLongitude: UILabel!
    
    var eventList = [EventDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchEventsJSON { (res) in
            switch res {
            case .success(let events):
                DispatchQueue.main.async
                    {self.labelLatitude.text = "\(events.events[1].locations[0].latitude)"
                    self.labelLongitude.text = "\(events.events[1].locations[0].longitude)"}
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
    
    override open var shouldAutorotate: Bool {
        return false
    }
}

// Source:
// https://spin.atomicobject.com/2017/07/18/swift-interface-builder/
import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


