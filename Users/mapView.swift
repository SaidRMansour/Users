
import Foundation
import MapKit
import SwiftUI



struct mapView: View {

    @State var users: Users.UserDetail
        
    //Make a temporary region - it is edited when i get the users
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 56.154070, longitude: 10.111430), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))

    //Make a temporary cllCoordinate - it is edited when i get the users
    @State private var cllCoordinate = CLLocationCoordinate2D(latitude: 56.154070, longitude: 10.111430)
    
    var body: some View {
        
        VStack{
            //Create a Map using MapKit library
            Map(coordinateRegion: $region, annotationItems: [users.location]) {user in
                //Setting a MapMarker as the default variable i have choosen
                MapMarker(coordinate: cllCoordinate, tint: .blue )
                
                //Async call (getting users)
            }.task {
                //Get long & lat from the incommen user
                let latitudeFromUser: Double = Double(users.location.coordinates!.latitude)!
                let longitudeFromUser: Double = Double(users.location.coordinates!.longitude)!
                //Setting Mapmarker variable to the input from user
                let clnew = CLLocationCoordinate2D(
                    latitude: latitudeFromUser,
                    longitude: longitudeFromUser)
                cllCoordinate = clnew
                
                //Setting region center (phone showing) to
                let cllCoordinate = CLLocationCoordinate2D.init(latitude: latitudeFromUser, longitude: longitudeFromUser)
                region.center = cllCoordinate
                
            }
            .ignoresSafeArea()
            
        }
        
    }
    
}

struct mapView_Previews: PreviewProvider {
    
    static var newUser = Users.UserDetail(name: Users.UserDetail.NameOfUser(title: "Hr", first: "Said", last: "Mansour"), location: Users.UserDetail.LocationOfUser(street: Users.UserDetail.LocationOfUser.StreetOfUser(number: 45, name: "Sigridsvej"), postcode: 8220, city: "Brabrand", coordinates: Users.UserDetail.LocationOfUser.CoordinateOfUSer(latitude: "56.15407", longitude: "10.111434")), dob: Users.UserDetail.DateOfBirthOfUser(date: Date(), age: 25), picture: Users.UserDetail.PicturesOfUser(medium: "", large: "", thumbnail: ""))
    
    static var previews: some View {
        mapView(users: newUser).environmentObject(viewModel())
    }
}

