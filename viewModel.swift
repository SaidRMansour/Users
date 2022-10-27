//
//  viewModel.swift
//  Users
//
//  Created by Alaa Trabulsi on 26/09/2022.
//

import Foundation
import UIKit
import _MapKit_SwiftUI

class viewModel: ObservableObject{
    @Published var users: [Users.UserDetail] = []
    
    
    @MainActor
    //Fetch function --> Get users
    func fetch() async throws -> Users{
        let userUrl = URL(string: "https://randomuser.me/api/?results=100&nat=dk")!
        let (data, _) = try await URLSession.shared.data(from: userUrl)
        let decoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "da_DK")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let newUser = try decoder.decode(Users.self, from: data)
        self.users = newUser.results
        
        //Tester output
        printUsers()

        
        //Return statement
       return newUser
    }
    
    //Make a user 
    func makeUser(_ item: Users.UserDetail){
        users.append(item)
        printUsers()

    }
    //Delete a user
    func deleteItemWith(id: String){
        let index = users.firstIndex { item in
            item.id == id
        }
        if let index = index{
            users.remove(at: index)
        }
        printUsers()
    }
    //Print the whole users
    func printUsers(){
        
        for user in users{
            
            print("\(user.name.first) \(user.name.last) Longitude: \(user.location.coordinates?.longitude ?? "No longitude") Latitude \(user.location.coordinates?.latitude ?? "No latitude")")
            
            let latitudeFromUser: Double = Double(user.location.coordinates!.latitude)!
            let longitudeFromUser: Double = Double(user.location.coordinates!.longitude)!
     
            
            print("Lat double: \(latitudeFromUser) Long double: \(longitudeFromUser)")
            }
    }
    
   
    
}
    
    


