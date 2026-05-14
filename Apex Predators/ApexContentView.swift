//
//  ContentView.swift
//  Apex Predators
//
//  Created by Akash Kumbhar on 13/05/26.
//

import SwiftUI

struct ContentView: View {
    var predatorsList = ApexPredatorList()
    @State var searchDinoText = ""
    @State var alphabetical = false
    @State var currentSelection = APType.all
    
    var filterdDinoList :  [ApexPredatorsModel] {
        predatorsList.sort(by: alphabetical)
        predatorsList.filter(by: currentSelection)
        return predatorsList.search(for: searchDinoText)
    }
    
    var body: some View {
        NavigationStack {
            // 1. The List starts here
            List(filterdDinoList) { predator in
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .black, radius: 1)
                        
                        VStack(alignment: .leading) {
                            Text(predator.name)
                                .font(.headline)
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 3)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchDinoText , placement: .navigationBarDrawer(displayMode: .always))
            .autocorrectionDisabled()
            .animation(.default,value: searchDinoText)
            .toolbar{
                ToolbarItem(placement:.topBarLeading){
                    Button{
                        withAnimation{
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce , value:alphabetical)
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Picker("Filter" , selection: $currentSelection){
                            ForEach(APType.allCases){
                                type in
                                Label(type.rawValue.capitalized, systemImage: type.icons)
                            }
                        }
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
