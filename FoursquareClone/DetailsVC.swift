//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Mehmet Can Şimşek on 17.03.2022.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsPlaceNamelabel: UILabel!
    @IBOutlet weak var detailsPlaceTypeLabel: UILabel!
    @IBOutlet weak var detailsPlaceAtmosphereLabel: UILabel!
    
    var chosenPlaceId = ""
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    @IBOutlet weak var detailsMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromParse()
        
    }
    
    func getDataFromParse () {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
            }else{
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenPlaceObject = objects![0]
                        
                        if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                            self.detailsPlaceNamelabel.text = placeName
                            
                        }
                        if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                            self.detailsPlaceTypeLabel.text = placeType
                        }
                        if let placeAtmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                            self.detailsPlaceAtmosphereLabel.text = placeAtmosphere
                        }
                        if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                            if let placeLatitudeDouble = Double(placeLatitude){
                                self.chosenLatitude = placeLatitudeDouble
                            }
                        }
                        if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                            if let placeLongitudeDoble = Double(placeLongitude) {
                                self.chosenLongitude = placeLongitudeDoble
                            }
                        }
                        if let imageDta = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            imageDta.getDataInBackground { data, error in
                                if error == nil {
                                    if data != nil {self.detailsImageView.image = UIImage(data: data!) }
                                }
                            }
                        }
                       
                        
                    }
                }
            }
        }
    }
   

}
