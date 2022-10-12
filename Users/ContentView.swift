//
//  ContentView.swift
//  Users
//
//  Created by Alaa Trabulsi on 26/09/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewmodel: viewModel
    var body: some View {
        
        NavigationView {
            List{
                ForEach($viewmodel.users, id: \.id){ $user in
                    NavigationLink(destination: userDetail(users: user)){
                        VStack{
                            HStack{
                                //IMAGE
                                AsyncImage(url: URL(string: user.picture.medium), content: { image in
                                            image.resizable()
                                        }, placeholder: {
                                            ProgressView()
                                        })
                                            .frame(width: 72, height: 72)
                                            .clipShape(Circle())
                                 
                                VStack(alignment: .leading){
                                    
                                    //Text for name
                                    Text("\(user.name.title). \(user.name.first) \(user.name.last)")
                                        .multilineTextAlignment(.leading)
                                        .fontWeight(.heavy)
                                        .font(.system(size: 17))
                                    
                                    //Text for Street & number
                                    Text("\(user.location.street.name) \(String(user.location.street.number))")
                                        .multilineTextAlignment(.leading)
                                    
                                    //Text for PostCode & City
                                    Text("\(String(user.location.postcode)) \(user.location.city)")
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }.swipeActions{
                        Button(role: .destructive){
                            viewmodel.deleteItemWith(id: user.id)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
            }
            
            .navigationTitle("Users")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    //Updating our list (fetch)
                    Button{
                        Task{
                            try? await viewmodel.fetch()
                        }
                    }label: {
                        Image(systemName: "person.2.gobackward")
                            .font(.system(size:25))
                        }
                }
                ToolbarItemGroup(placement: .navigationBarLeading){
                    NavigationLink(destination: creatUser()){
                        Image(systemName: "person.fill.badge.plus")
                            .font(.system(size:25))

                    }
                }
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(viewModel())
    }
}
