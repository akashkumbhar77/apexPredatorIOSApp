//
//  apexPredatorDetailView.swift
//  Apex Predators
//
//  Created by Akash Kumbhar on 15/05/26.
//

import SwiftUI
import MapKit

struct ApexPredatorDetailView: View {
    
    let predator : ApexPredatorsModel
    @State var cameraPosition : MapCameraPosition
    
    @Namespace var namespace
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                ZStack{
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1.0)
                                
                            ]
                                           , startPoint: .top, endPoint: .bottom)
                        }
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(x:-1)
                        .shadow(color: .black, radius: 10)
                        .frame(width: geo.size.width / 1.5,height: geo.size.height / 3.7)
                        .offset(y: 20)
                    
                }
                
                // Dino Name
                
                VStack(alignment: .leading){
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    NavigationLink{
                        PredatorMapView(camera: .camera(MapCamera(centerCoordinate: predator.location, distance: 3000 , heading: 250 , pitch: 80)))
                            .navigationTransition(.zoom(sourceID: 1, in: namespace))
                         
                        
                    }label: {
                        Map(position: $cameraPosition){
                            Annotation(predator.name , coordinate: predator.location){
                                Image(systemName: "mappin.and.ellipse")
                                    .imageScale(.large)
                                    .font(.title)
                                    .symbolEffect(.bounce)
                            }
                            .annotationTitles(.hidden)
                            
                        }
                    }
                    .frame(height: 130)
                    .overlay(alignment:.trailing){
                        Image(systemName: "greaterthan")
                            .imageScale(.large)
                            .font(.title3)
                            .padding(.trailing,10)
                    }
                    .overlay(alignment:.topLeading){
                        Text("Current Location")
                            .padding([.top, .leading] , 5)
                            .font(.headline)
                            .background(.black.opacity(0.33))
                            .clipShape(.rect(cornerRadius: 15))
                    }
                    .clipShape(.rect(cornerRadius: 15))
                    .matchedTransitionSource(id: 1, in: namespace)
                    
                    Text("Appears in : ")
                        .font(.title3)
                        .padding(.top,10)
                    
                    ForEach(predator.movies , id:\.self){
                        movie in
                        Text(">> " + movie)
                            .font(.subheadline)
                    }
                    
                    
                    
                    Text("Movie Moments ")
                        .font(.title)
                        .padding(.top , 15)
                    
                    ForEach(predator.movieScenes){scenes in
                        
                        Text(scenes.movie)
                            .font(.title2)
                            .padding(.vertical,1)
                        Text(scenes.sceneDescription)
                            .padding(.bottom,15)
                        
                    }
                    Text("Read More : ")
                        .font(.subheadline)
                        .padding(.top , 15)
                    Link(predator.link, destination: URL(string : predator.link)!)
                        .font(.title)
                    
                }
                .padding(.leading,10)
                .padding(.trailing,10)
                .padding(.bottom, 15)
                .frame(width: geo.size.width , alignment: .leading)
                
            }
            .ignoresSafeArea()
            .toolbarBackground(.automatic)
            .preferredColorScheme(.dark)
            
        }
    }
}

#Preview {
    
    let predator  = ApexPredatorList().apexPredatorList[2]
    
    NavigationStack{
        ApexPredatorDetailView(predator: predator, cameraPosition: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
    }
}
