//
//  ProspectsView.swift
//  Project16-HotProspects
//
//  Created by Ryan Token on 9/19/21.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortSheet = false
    @State private var sortingByName = false
    @State private var sortingByRecency = false
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            if (sortingByName) {
                let sortedProspects = prospects.people.sorted(by: { $0.name > $1.name })
                return sortedProspects
            }
            
            if (sortingByRecency) {
                let sortedProspects = prospects.people.sorted(by: { $0.scanDate > $1.scanDate })
                return sortedProspects
            }
            
            return prospects.people
        case .contacted:
            if (sortingByName) {
                let sortedProspects = prospects.people.sorted(by: { $0.name > $1.name })
                return sortedProspects
            }
            
            if (sortingByRecency) {
                let sortedProspects = prospects.people.sorted(by: { $0.scanDate > $1.scanDate })
                return sortedProspects
            }
            
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            if (sortingByName) {
                let sortedProspects = prospects.people.sorted(by: { $0.name > $1.name })
                return sortedProspects
            }
            
            if (sortingByRecency) {
                let sortedProspects = prospects.people.sorted(by: { $0.scanDate > $1.scanDate })
                return sortedProspects
            }
            
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                            
                            .contextMenu {
                                Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                                    prospects.toggle(prospect)
                                }
                                if !prospect.isContacted {
                                    Button("Remind Me") {
                                        self.addNotification(for: prospect)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        if prospect.isContacted {
                            Image(systemName: "person.fill.checkmark")
                        } else {
                            Image(systemName: "person.fill.xmark")
                        }
                    }
                }
            }
            
            .actionSheet(isPresented: $isShowingSortSheet) {
                ActionSheet(title: Text("Sort Prospects"), message: Text("Select a method of sorting"), buttons: [
                    .default(Text("Name")) { sortByName() },
                    .default(Text("Recency")) { sortByRecency() },
                    .cancel()
                ])
            }
            
            .navigationBarTitle(title)
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingSortSheet = true
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }

                    Button(action: {
                        isShowingScanner = true
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scan")
                    }
                }
            }
            
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Ryan Token\nryan@test.net", completion: handleScan)
            }
        }
    }
    
    func sortByName() {
        sortingByName = true
    }
    
    func sortByRecency() {
        sortingByRecency = true
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       isShowingScanner = false
       
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            person.scanDate = Date()

            prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        // addRequest is a closure
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
