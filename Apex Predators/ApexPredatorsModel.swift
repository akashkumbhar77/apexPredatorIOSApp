//
//  ApexPredators.swift
//  Apex Predators
//
//  Created by Akash Kumbhar on 13/05/26.
//

import Foundation
import SwiftUI

struct ApexPredatorsModel : Decodable , Identifiable  {
    let id : Int
    let name : String
    let type : APType
    let latitude : Double
    let longitude : Double
    let movies : [String]
    
    let movieScenes : [MovieScene]
    let link : String
    
    var image: String{
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScene : Decodable{
        let id : Int
        let movie: String
        let sceneDescription: String
    }
    
    enum APType : String , Decodable {
        case land
        case air
        case sea
        
        var background : Color {
           
            switch self {
            case .land:
                Color.brown
            case .air:
                Color.teal
            case .sea:
                Color.blue
            }
        }
    }
}
