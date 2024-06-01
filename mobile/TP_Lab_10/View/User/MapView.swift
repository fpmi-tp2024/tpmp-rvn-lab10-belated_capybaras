//
//  MapView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 31/05/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 53.9023, longitude: 27.5619),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    let pointsOfInterest: [PointOfInterest] = [
        PointOfInterest(name: "Minsk", coordinate: CLLocationCoordinate2D(latitude: 53.9023, longitude: 27.5619)),
        PointOfInterest(name: "Near Minsk", coordinate: CLLocationCoordinate2D(latitude: 53.9153, longitude: 27.6622)),
        PointOfInterest(name: "Near Minsk 2", coordinate: CLLocationCoordinate2D(latitude: 53.9247, longitude: 27.5668)),
        PointOfInterest(name: "Near Minsk 3", coordinate: CLLocationCoordinate2D(latitude: 53.9079, longitude: 27.4683)),
        PointOfInterest(name: "Near Minsk 4", coordinate: CLLocationCoordinate2D(latitude: 53.9529, longitude: 27.4683))
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: pointsOfInterest) { point in
            MapAnnotation(coordinate: point.coordinate) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                    .imageScale(.large)
                    .font(.title3)
                    .foregroundColor(.red)
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PointOfInterest: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

#Preview {
    MapView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
