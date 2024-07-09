//
//  ToDoItemDetailsViewController.swift
//  ToDo
//
//  Created by Shoumik on 02/06/24.
//

import UIKit
import MapKit

class ToDoItemDetailsViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var doneButton: UIButton!
    
    var toDoItem: ToDoItem? {
        didSet {
            titleLabel.text = toDoItem?.title
            if let coordinate = toDoItem?.location?.coordinate {
                mapView.setCenter(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), animated: false)
            }
            doneButton.isEnabled = (toDoItem?.done == false)
        }
    }
    var toDoItemStore: ToDoItemStoreProtocol?
    
    @IBAction func checkItem(_ sender: Any) {
        if let toDoItem {
            toDoItemStore?.check(toDoItem)
        }
    }
}
