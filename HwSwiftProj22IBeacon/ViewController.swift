//
//  ViewController.swift
//  HwSwiftProj22IBeacon
//
//  Created by Alex Wibowo on 28/9/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view1.layer.cornerRadius = 128
        view2.layer.cornerRadius = 128
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                        startMonitoring(uuid: UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!, identifier: "MyIPAD")
                        startMonitoring(uuid: UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935")!, identifier: "My6S")
                }
            }
        }
    }
    
    
    func startMonitoring(uuid: UUID, identifier: String) {
        
        let region = CLBeaconRegion(uuid: uuid, major: 0, minor: 0, identifier: identifier)
        locationManager?.startMonitoring(for: region)
        locationManager?.startRangingBeacons(in: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let firstBeacon = beacons.first {
            let proximity = firstBeacon.proximity
            
            var scale: CGFloat
            
            
            switch proximity {
                case .immediate:
                    scale = 1
                case .near:
                    scale = 0.7
                case .far:
                    scale = 0.5
                default:
                    scale = 0.25
            }
            
            if region.identifier == "MyIPAD" {
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) { [weak self] in
                    
                    self?.view1.transform = CGAffineTransform(scaleX: scale, y: scale)
                } completion: { complete in
                    
                }

                
            }
            if region.identifier == "My6S"{
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) { [weak self] in
                    
                    self?.view2.transform = CGAffineTransform(scaleX: scale, y: scale)
                    
                    
                } completion: { complete in
                    
                }
            }
        }
       
    }

}

