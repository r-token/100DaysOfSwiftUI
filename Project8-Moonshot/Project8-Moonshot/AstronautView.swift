//
//  AstronautView.swift
//  Project8-Moonshot
//
//  Created by Ryan Token on 7/21/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matchedMissions = [Mission]()
        
        for mission in missions {
            for crewMember in mission.crew {
                if astronaut.id == crewMember.name {
                    matchedMissions.append(mission)
                }
            }
        }
        
        self.missions = matchedMissions
    }
    

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                
                    VStack {
                        Text("Missions:")
                            .font(.title3)
                        ForEach(missions) { mission in
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                
                                Text(mission.displayName)
                                    .font(.headline)
                            }
                        }

                    Text(astronaut.description)
                        .padding()
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
