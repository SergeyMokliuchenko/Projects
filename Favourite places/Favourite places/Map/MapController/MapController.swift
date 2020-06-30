//
//  MapController.swift
//  Favourite places
//
//  Created by Serhii Mokliuchenko on 14.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import GoogleMaps
import GooglePlaces

protocol MapControllerDelegate {
    func didTap(on marker: MapMarker?)
}

class MapController: NSObject {
    
    private var view: UIView
    private var selectedMarker: MapMarker?
    private let locationManager: LocationManager
    private var mapView: GMSMapView?
    private var polyline: GMSPolyline = GMSPolyline.init()
    private var clusterManager: GMUClusterManager!
    private var currentLocation: CLLocation?
    private var zoomLevel: Float = 15.0
    private var travelModes: String
    private var tempMarker: MapMarker?
    
    var delegate: MapControllerDelegate?
    private var markers: [MapMarker] = []
    
    init(view: UIView, locationManager: LocationManager = LocationManager(), travelModes: String = "driving") {
        self.view = view
        self.locationManager = locationManager
        self.travelModes = travelModes
        
        super.init()
        self.setupDelegates()
    }
    
    private func setupDelegates() {
        locationManager.delegate = self
        mapView?.delegate = self
    }
    
    private func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 37.33, longitude: -122.03, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        mapView?.settings.myLocationButton = true
        mapView?.isMyLocationEnabled = true
        view.addSubview(mapView!)
    }
    
    private func setupClusterManager() {
        let iconGenerator = GMUDefaultClusterIconGenerator.init(buckets: [4, 10, 20], backgroundColors: [.blue, .red, .green])
        let algoritm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let render = GMUDefaultClusterRenderer(mapView: mapView!, clusterIconGenerator: iconGenerator)
        render.delegate = self
        clusterManager = GMUClusterManager(map: mapView!, algorithm: algoritm, renderer: render)
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
        generateClusterItems()
    }
    
    private func generateClusterItems() {
        self.clusterManager.clearItems()
        for marker in markers {
            clusterManager.add(marker)
        }
    }
    
    func setUpDirection() {
        guard let marker = selectedMarker, let currentLocation = self.currentLocation else { return }
        let requestManager = RequestManager()
        requestManager.getDirection(origin: "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)", destination: "\(marker.position.latitude),\(marker.position.longitude)", selectedMode: travelModes, completion: { routes in
            
            self.polyline.map = nil
            for route in routes {
                
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let patch = GMSPath.init(fromEncodedPath: points!)
                self.polyline = GMSPolyline.init(path: patch)
                self.polyline.strokeColor = UIColor.blue
                self.polyline.strokeWidth = 2
                self.polyline.map = self.mapView
            }
        })
    }
    
    func createTempMarker(place: PlaceModel) {
        tempMarker?.place = place
        appendNewMarker()
    }
    
    private func appendNewMarker() {
        guard let tempMarker = self.tempMarker else { return }
        markers.append(tempMarker)
        self.tempMarker = nil
        generateClusterItems()
    }
}

extension MapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let marker = marker.userData as? MapMarker
        delegate?.didTap(on: marker)
        selectedMarker = marker
        return false
    }
}

extension MapController: GMUClusterManagerDelegate {
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position, zoom: mapView!.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView?.moveCamera(update)
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        delegate?.didTap(on: nil)
        tempMarker = MapMarker.init(position: coordinate, place: nil)
        selectedMarker = nil
    }
}

extension MapController: GMUClusterRendererDelegate {
    
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {}
}

extension MapController: LocationManagerDelegate {
    
    func didChangeLocation(to location: CLLocation) {
        self.currentLocation = location
    }
    
    func authorizedLocation() {
        setupMapView()
        setupClusterManager()
        locationManager.requestCurrentLocation()
    }
}
    
extension MapController {
    
    func saveMarkers() {
        let encoded = try? JSONEncoder().encode(markers)
        UserDefaults.standard.set(encoded, forKey: "Markers")
    }
    
    func loadMarkers() {
        guard let mapMarker = UserDefaults.standard.object(forKey: "Markers") as? Data else { return }
        let decoded = try! JSONDecoder().decode([MapMarker].self, from: mapMarker)
        markers.append(contentsOf: decoded)
    }
    
    func deleteMarker() {
        saveMarkers()
        generateClusterItems()
    }
    
    func getMarkers() -> [MapMarker] {
        return markers
    }
    
    func recordMarkers(array: [MapMarker]) {
        markers = array
    }
    
    func removePlace(place: Int) {
        markers.remove(at: place)
    }
    
    func didSelect(marker: MapMarker) {
        selectedMarker = marker
    }
    
    func selectTravelModes(modes: String) {
        travelModes = modes
    }
}
