//
//  MissionView.swift
//  Project8-Moonshot
//
//  Created by Ryan Token on 7/21/21.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    let allMissions: [Mission] = Bundle.main.decode("missions.json")
    let frameHeight: CGFloat = 300
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geometry in
                        HStack {
                            Spacer()
                            
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: fullView.size.width * 0.7)
                                .padding()
                                .offset(x: 0, y: getOffsetForMissionPatch(for: geometry))
                                .scaleEffect(getScaleOfMissionPatch(for: geometry))
                            
                            Spacer()
                        }
                        
                    }
                    .frame(height: frameHeight, alignment: .center)
                        
                    HStack {
                        Text("Launch Date:")
                        Text(mission.formattedLaunchDate)
                    }
                    .font(.headline)
                    
                    Text(mission.description)
                        .padding()
                    
                    ForEach(astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: allMissions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    func getOffsetForMissionPatch(for geometry: GeometryProxy) -> CGFloat {
        let scale = getScaleOfMissionPatch(for: geometry)
        return self.frameHeight * (1 - scale) * 0.95
    }

    func getScaleOfMissionPatch(for geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).minY
        let halfHeight = self.frameHeight / 2

        // This value was found by just printing the minY of .global at the start
        let startingOffset: CGFloat = 91

        let minimumSizeAtOffset = startingOffset - halfHeight
        let scale = 0.8 + 0.2 * (offset - minimumSizeAtOffset) / halfHeight

        if scale < 0.8 {
            return 0.8
        } else if scale > 1.2 {
            return 1.2
        }

        return scale
    }
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
