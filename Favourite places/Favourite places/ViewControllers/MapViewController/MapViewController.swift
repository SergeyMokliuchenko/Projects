//
//  ViewController.swift
//  Favourite places
//
//  Created by Serhii Mokliuchenko on 14.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyStarRatingView

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starRatingView: SwiftyStarRatingView!
    @IBOutlet weak var infoViewBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var showPlacesButton: UIButton!
    @IBOutlet weak var placesListView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placesListViewBottomConstraints: NSLayoutConstraint!
    
    private var mapController: MapController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }
    
    private func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: String(describing: CustomTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CustomTableViewCell.self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMap()
        mapController?.loadMarkers()
    }
    
    private func setupMap() {
        mapController = MapController.init(view: mapView, locationManager: LocationManager())
        mapController?.delegate = self
    }
    
    @IBAction func TravelModesControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapController!.selectTravelModes(modes: "driving")
        case 1:
            mapController!.selectTravelModes(modes: "walking")
        default:
            break
        }
    }
    
    @IBAction func directionAction(_ sender: UIButton) {
        mapController?.setUpDirection()
    }
    
    @IBAction func showPlasesAction(_ sender: UIButton) {
        hideInfoView()
        showPlacesListView()
    }
    
    private func hideInfoView() {
        infoViewBottomConstraints.constant = 150
        animatedLayout()
    }
    
    private func showPlacesListView() {
        showPlacesButton.alpha = 0
        placesListViewBottomConstraints.constant = 10
        tableView.reloadData()
        animatedLayout()
    }
    
    private func animatedLayout() {
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func hidePlacesAction(_ sender: UIButton) {
        hidePlacesListView()
    }
    
    private func hidePlacesListView() {
        showPlacesButton.alpha = 1
        placesListViewBottomConstraints.constant = -260
        animatedLayout()
    }
}

extension MapViewController: MapControllerDelegate {
    
    func didTap(on marker: MapMarker?) {
        if let marker = marker {
            hidePlacesListView()
            showInfoView()
            updateInfoView(with: marker.place!)
        } else {
            hidePlacesListView()
            hideInfoView()
            addNewPlace()
        }
    }
    
    private func addNewPlace() {
        let addMarkerVC = AddMarkerViewController.init(nibName: "AddMarkerViewController", bundle: nil)
        addMarkerVC.modalPresentationStyle = .overFullScreen
        addMarkerVC.modalTransitionStyle = .coverVertical
        addMarkerVC.addCompletionHandler = { place in
            self.mapController?.createTempMarker(place: place)
            self.mapController?.saveMarkers()
        }
        self.present(addMarkerVC, animated: true)
    }
    
    private func showInfoView() {
        infoViewBottomConstraints.constant = 0
        animatedLayout()
    }
    
    private func updateInfoView(with place: PlaceModel) {
        titleLabel.text = place.name
        descriptionLabel.text = place.description
        starRatingView.value = CGFloat(place.starRating)
    }
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let quantity = mapController?.getMarkers() else { return 0 }
        return quantity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomTableViewCell.self)) as! CustomTableViewCell
        guard let marker = mapController?.getMarkers()[indexPath.row] else { return cell }
        cell.fillWith(model: marker)
        cell.deleteCompletion = {
            
            let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { [weak self] action in
                self?.mapController?.removePlace(place: indexPath.row)
                self?.mapController?.deleteMarker()
                self?.tableView.reloadData()
            }
            alert.addAction(cancelButton)
            alert.addAction(deleteButton)
            
            self.present(alert, animated: true, completion: nil)
        }
        cell.shareCompletion = {
            let share = "Place: \(marker.place?.name ?? "")\nDescription: \(marker.place?.description ?? "")\nCoordinates: \(marker.position.latitude),\(marker.position.longitude)"
            let shareController = UIActivityViewController(activityItems: [share], applicationActivities: nil)
            self.present(shareController, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let marker = mapController?.getMarkers()[indexPath.row] else { return }
        hidePlacesListView()
        showInfoView()
        mapController?.didSelect(marker: marker)
    }
}
