//
//  PredatorMapView.swift
//  Apex Predators
//
//  Created by Akash Kumbhar on 19/05/26.
//

import SwiftUI
import MapKit

struct PredatorMapView: View {
    
    @State var camera : MapCameraPosition
    @State var statellite = false
    
    let predators = ApexPredatorList().allApexPredatorList
    
    var body: some View {
        Map(position: $camera) {
            ForEach(predators) { predator in
                
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100 )
                        .shadow( color: .white, radius: 20)
                        .scaleEffect(x: -1)
                }
                
            }
        }
        .mapStyle(statellite ? .imagery(elevation: .realistic) : .standard(elevation: .automatic))
        .overlay(alignment: .bottomTrailing){
            Button{
                statellite.toggle()
            }label: {
                Image(systemName: statellite ? "globe.americas.fill" : "globe.americas" )
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(.trailing,10)
            }
        }
    }
}

#Preview {
    PredatorMapView(camera: .camera(MapCamera(centerCoordinate: ApexPredatorList().allApexPredatorList[2].location, distance: 30000,heading: 250,pitch: 80)))
        .preferredColorScheme(.dark)
}
