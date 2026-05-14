//
//  ApexPredatorList.swift
//  Apex Predators
//
//  Created by Akash Kumbhar on 13/05/26.
//

import Foundation


class ApexPredatorList {
    var apexPredatorList : [ApexPredatorsModel] = []
    
    init (){
        decodeApexPredatorData()
    }
    
    
    func decodeApexPredatorData(){
        if let bodyUrl = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do{
                let data = try Data(contentsOf: bodyUrl)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                apexPredatorList = try jsonDecoder.decode([ApexPredatorsModel].self, from: data)
                print(apexPredatorList)
            }catch{
                print("Error decoding data \(error)")
            }
        }
    }
    
    
    func sort(by alphabetical : Bool){
        apexPredatorList.sort{ predator1 , predator2 in
            if alphabetical{
                predator1.name < predator2.name
            }
            else{
                predator1.id < predator2.id
            }
        }
    }
    
    func search(for searchTerm : String)-> [ApexPredatorsModel]{
        if searchTerm.isEmpty {
            return  apexPredatorList
        }
        else{
            return apexPredatorList.filter{predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
}
