//
//  userDetail.swift
//  Users
//
//  Created by Alaa Trabulsi on 29/09/2022.
//

import SwiftUI

struct userDetail: View {
    //Binding betweeen users and this Detail view
    //getting the original data (also if changed)
    @State var users: Users.UserDetail
    @EnvironmentObject var viewmodel: viewModel

    
    var body: some View {
        NavigationView{
            VStack{
                //Calling async for Image URL
                AsyncImage(url: URL(string: users.picture.large), content: { image in
                    image.resizable()
                }, placeholder: {
                    //Placeholder is taken by progressView() until it find the image
                    ProgressView()
                })
                .frame(width: 250, height: 250)
                //Circle picture
                .clipShape(Circle())
                
                VStack{
                    VStack{
                        Text("Name: ")
                            .fontWeight(.heavy)
                            .font(.system(size: 20))
                        Text("\(users.name.title) \(users.name.first) \(users.name.last)")
                    }
                    Spacer()
                        .frame(height: 50)
                    VStack{
                        Text("Adress: ")
                            .fontWeight(.heavy)
                            .font(.system(size: 20))
                        VStack{
                            Text("\(users.location.street.name) \(String(users.location.street.number))")
                            Text("\(String(users.location.postcode)) \(users.location.city)")
                        }
                    }
                    Spacer()
                        .frame(height: 50)
                    VStack{
                        Text("Age: ")
                            .fontWeight(.heavy)
                            .font(.system(size: 20))
                        Text("\(String(users.dob.age)) Years old")
                    }
                    Spacer()
                        .frame(height: 50)
                    VStack{
                        Text("Birthdate")
                            .fontWeight(.heavy)
                            .font(.system(size: 20))
                        Text("\(users.dob.date.formatted(.dateTime.day().month().year()))")
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer()
                NavigationLink(destination: mapView(users: users)){
                    Text("Se min lokation")
                    Image(systemName: "map.circle.fill")
                        .font(.system(size:45))
                }
            }
            
            
            
            
        }
    }
}

struct userDetail_Previews: PreviewProvider {
   
    static var newUser = Users.UserDetail(name: Users.UserDetail.NameOfUser(title: "Hr", first: "Said", last: "Mansour"), location: Users.UserDetail.LocationOfUser(street: Users.UserDetail.LocationOfUser.StreetOfUser(number: 45, name: "Sigridsvej"), postcode: 8220, city: "Brabrand"), dob: Users.UserDetail.DateOfBirthOfUser(date: Date(), age: 25), picture: Users.UserDetail.PicturesOfUser(medium: "", large: "", thumbnail: ""))
    
    static var previews: some View {
        
        userDetail(users: newUser)
    }
}
