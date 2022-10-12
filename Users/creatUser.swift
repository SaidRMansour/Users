//
//  creatUser.swift
//  Users
//
//  Created by Alaa Trabulsi on 29/09/2022.
//

import SwiftUI

struct creatUser: View {
    
    //For the whole file
    @EnvironmentObject var viewmodel: viewModel
    @Environment(\.dismiss) var dismiss
    @State private var hoverVar = false
    var backGroundForFields = (Color(red: 242/255, green: 242/255, blue: 242/255))

    //For name
    @State var title: String = "" //-- @State is owned by this view
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    //For Adress
    @State var streetName: String = ""
    @State var streetNumber: String = ""
    @State var postCode: String = ""
    @State var city: String = ""
    
    //For Pictures
    @State var medium: String = ""
    @State var large: String = ""
    @State var thumbnail: String = ""

    
    //DATEPICKER
    @State private var date = Date()
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 1960, month: 1, day: 1) //Min
        let endComponents = DateComponents(year: 2004, month: 12, day: 31, hour: 23, minute: 59, second: 59) //Max
        return calendar.date(from:startComponents)!
            ... //Generate a datepicker between min and max
            calendar.date(from:endComponents)!
    }()
    
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){ // For scrolling since we have many textfields
                
                VStack{
                    Text("Create User")
                        .font(.largeTitle)
                        .bold()
                    Image(systemName: "person.fill.badge.plus")
                        .font(.system(size:100))
                        
                    Spacer()
                    Text("Name: ")
                    TextField("Title", text: $title)
                        .padding(20)
                        .background(backGroundForFields)
                        .cornerRadius(5)
                        .padding()
                    HStack{
                        TextField("First", text: $firstName)
                            .padding(20)
                            .background(backGroundForFields)
                            .cornerRadius(5)
                            .padding()
                        TextField("Last", text: $lastName)
                            .padding(20)
                            .background(backGroundForFields)
                            .cornerRadius(5)
                            .padding()
                    }
                    Text("Adress: ")
                    VStack{
                        TextField("Adresse", text: $streetName)
                            .padding(20)
                            .background(backGroundForFields)
                            .cornerRadius(5)
                            .padding()
                        HStack{
                            TextField("Nummer", text: $streetNumber)
                                .padding(20)
                                .background(backGroundForFields)
                                .cornerRadius(5)
                                .padding()
                            TextField("PostCode", text: $postCode)
                                .padding(20)
                                .background(backGroundForFields)
                                .cornerRadius(5)
                                .padding()
                        }
                        TextField("City", text: $city)
                            .padding(20)
                            .background(backGroundForFields)
                            .cornerRadius(5)
                            .padding()
                    }
                    Text("Birthdate")

                    VStack{
                            DatePicker(
                                    "",
                                     selection: $date,
                                     in: dateRange,
                                    displayedComponents: [.date, .hourAndMinute]
                            ).padding(.trailing, 70)

                        
                        //For pictures
                        Text("Pictures")
                        TextField("Medium", text: $medium)
                            .padding(20)
                            .background(backGroundForFields)
                            .cornerRadius(5)
                            .padding()
                        TextField("Large", text: $large)
                            .padding(20)
                            .background(backGroundForFields)
                            .cornerRadius(5)
                            .padding()
                        TextField("Thumnail", text: $thumbnail)
                            .padding(20)
                            .background(backGroundForFields)
                            .cornerRadius(5)
                            .padding()
                        
                    }
                    
                }
                if(title != "" && firstName != "" && lastName != "" && streetName != "" && streetNumber != "" && postCode != "" && city != "" && medium != ""){
                    Text("Opret")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(hoverVar ? Color.green : Color.blue)
                        .cornerRadius(20)
                    
                        .onTapGesture {
                            
                            
                            
                            //NEW USER INPUTS IS CONVERTET
                            let newName = Users.UserDetail.NameOfUser(title: title, first: firstName, last: lastName)
                            let newLocation = Users.UserDetail.LocationOfUser(street: Users.UserDetail.LocationOfUser.StreetOfUser(number: Int(streetNumber)!, name: streetName), postcode: Int(postCode)!, city: city)
                            /* Not used
                             let dateFormat = DateFormatter()
                             dateFormat.dateFormat = "yyyy/MM/dd'T'HH:mm:ss.SSS'Z'"
                             dateFormat.locale = Locale(identifier: "da_DK")
                             dateFormat.timeZone = TimeZone(secondsFromGMT: 3600)
                             let dateForUser = dateFormat.string(from: date)
                             let dateForUserInDate = dateFormat.date(from: dateForUser)
                             */
                            //Getting age from insertet Date
                            let now = Date()
                            let calendar = Calendar.current
                            let ageComponents = calendar.dateComponents([.year], from: date, to: now)
                            let ageForUser = ageComponents.year
                            
                            //Convert the date & pictures to struct of Users
                            let newDob = Users.UserDetail.DateOfBirthOfUser(date: date, age: ageForUser!)
                            let newPictures = Users.UserDetail.PicturesOfUser(medium: medium, large: medium, thumbnail: medium)
                            
                            //New user is ready
                            let newUser = Users.UserDetail(name: newName, location: newLocation, dob: newDob, picture: newPictures)
                            
                            //Appending newUser to list
                            viewmodel.makeUser(newUser)
                            
                            hoverVar.toggle()
                            
                            //CLEAR EVERYTHING
                            withAnimation{
                                title = ""
                                firstName = ""
                                lastName = ""
                                streetName = ""
                                streetNumber = ""
                                postCode = ""
                                city = ""
                                medium = ""
                                dismiss()
                            }
                        }
                }
            }
        }
    }
}

struct creatUser_Previews: PreviewProvider {
    static var previews: some View {
        creatUser().environmentObject(viewModel())
    }
}
