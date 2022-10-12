//
//  model.swift
//  Users
//
//  Created by Alaa Trabulsi on 26/09/2022.
//

import Foundation

struct Users:Decodable{
    var results: [UserDetail]

    struct UserDetail: Identifiable, Decodable{
        
       
        
        var name: NameOfUser
        var location: LocationOfUser
        var dob: DateOfBirthOfUser
        var picture: PicturesOfUser

        let id = UUID().uuidString

        
        struct NameOfUser: Decodable{
            var title: String
            var first: String
            var last: String
            
        }
        
        struct LocationOfUser: Identifiable, Decodable{
            var street: StreetOfUser
            var postcode: Int
            var city: String
            var coordinates: CoordinateOfUSer?
            let id = UUID().uuidString



            
            struct StreetOfUser: Decodable{
                var number: Int
                var name: String
            }
            
            struct CoordinateOfUSer:Decodable{
                var latitude: String
                var longitude: String

            }
        }
        
        struct DateOfBirthOfUser: Decodable{
            var date: Date
            var age: Int
        }
        
        struct PicturesOfUser: Decodable{
            var medium: String
            var large: String
            var thumbnail: String
        }
        
        
    }
}
