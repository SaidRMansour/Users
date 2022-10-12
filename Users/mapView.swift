
import Foundation
import MapKit
import SwiftUI

struct mapView: View {

    @State var users: Users.UserDetail
    @State private var userTrackMode: MapUserTrackingMode = .follow
    @State private var mkCoordinate = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 57, longitude: 14), latitudinalMeters: 50, longitudinalMeters: 50)
    
    var body: some View {
        
        VStack{
            
            Map(coordinateRegion: $mkCoordinate, annotationItems: [users.location]){ user in
                MapMarker(coordinate: mkCoordinate.center, tint: .accentColor)
            }
            
            .task {
                let latitudeFromUser: Double = Double(users.location.coordinates!.latitude)!
                let longitudeFromUser: Double = Double(users.location.coordinates!.longitude)!
                
                print(latitudeFromUser)
                print(longitudeFromUser)
                let cllCoordinate = CLLocationCoordinate2D.init(latitude: latitudeFromUser, longitude: longitudeFromUser)
                
                mkCoordinate = MKCoordinateRegion(center: cllCoordinate, latitudinalMeters: 50, longitudinalMeters: 50)
                
            }
            .ignoresSafeArea()
            
        }
        
    }
    
}

struct mapView_Previews: PreviewProvider {
    
    static var newUser = Users.UserDetail(name: Users.UserDetail.NameOfUser(title: "Hr", first: "Said", last: "Mansour"), location: Users.UserDetail.LocationOfUser(street: Users.UserDetail.LocationOfUser.StreetOfUser(number: 45, name: "Sigridsvej"), postcode: 8220, city: "Brabrand"), dob: Users.UserDetail.DateOfBirthOfUser(date: Date(), age: 25), picture: Users.UserDetail.PicturesOfUser(medium: "", large: "", thumbnail: ""))
    
    static var previews: some View {
        mapView(users: newUser)
    }
}

