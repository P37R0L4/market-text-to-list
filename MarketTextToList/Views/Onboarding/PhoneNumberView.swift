//
//  PhoneNumberView.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 05/11/23.
//

import SwiftUI
import Combine

struct PhoneNumberView: View {
    @State var presentSheet = false
    @State var countryCode: String = "+55"
    @State var mobPhoneNumber: String = ""
    @State var countryFlag: String = "🇧🇷"
    @State var countryPattern: String = "## # #### ####"
    @State var countryLimit: Int = 17
    @State var pushToPassword: Bool = false
    @State var showHomeView: Bool = false
    @State var completePhoneNumber: String = ""
    
    @State private var searchCountry: String = ""
    
    private let countries: [CPData] = Bundle.main.decode("CountryNumbers.json")
    
    var body: some View {
        GeometryReader { geo in
            let hasHomeIndicator = geo.safeAreaInsets.bottom > 0
            
            NavigationStack {
                VStack {
                    TitleOnboadingView(
                        hasHomeIndicator: hasHomeIndicator,
                        text: "Confirm country code and enter phone number"
                    )
                    
                    HStack {
                        Button {
                            presentSheet = true
                        } label: {
                            Text("\(countryFlag) \(countryCode)")
                                .padding(10)
                                .frame(minWidth: 80, minHeight: 47)
                                .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .foregroundColor(.secondary)
                        }
                        
                        TextField("", text: $mobPhoneNumber)
                            .placeholder(when: mobPhoneNumber.isEmpty) {
                                Text("Phone number")
                                    .foregroundColor(.secondary)
                            }
                            .keyboardType(.phonePad)
                            .padding(10)
                            .frame(minWidth: 80, minHeight: 47)
                            .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .onReceive(Just(mobPhoneNumber)) { _ in
                                applyPatternOnPhoneNumbers(&mobPhoneNumber, pattern: countryPattern, replacementCharacter: "#")
                            }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 15)
                    
                    Button("Next") {
                        buttonAction()
                    }
                    .disableWithOpacity(mobPhoneNumber.count < 1)
                    .buttonStyle(OnboardingButtonStyle())
                }
                .navigationDestination(isPresented: $pushToPassword) {
                    SignInPasswordView(completePhoneNumber: $completePhoneNumber)
                }
                .navigationDestination(isPresented: $showHomeView) {
                    ContentView()
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .onAppear {
                let userPhone = Prefs.shared.sharedPhoneNumber
                
                if userPhone != nil {
                    showHomeView = true
                }
            }
            .sheet(isPresented: $presentSheet) {
                NavigationView {
                    List(filteredResorts) { country in
                        HStack {
                            Text(country.flag)
                            Text(country.name)
                                .font(.headline)
                            Spacer()
                            Text(country.dial_code)
                                .foregroundColor(.secondary)
                        }
                        .onTapGesture {
                            self.countryFlag = country.flag
                            self.countryCode = country.dial_code
                            self.countryPattern = country.pattern
                            self.countryLimit = country.limit
                            presentSheet = false
                            searchCountry = ""
                        }
                    }
                    .listStyle(.plain)
                    .searchable(text: $searchCountry, prompt: "Your country")
                }
                .presentationDetents([.medium, .large])
            }
            .presentationDetents([.medium, .large])
        }
        .ignoresSafeArea(.keyboard)
    }
    
    func buttonAction () {
        let trimCountryCode = countryCode.replacingOccurrences(of: "+", with: "")
        let trimNumber = mobPhoneNumber.replacingOccurrences(of: " ", with: "")
        completePhoneNumber = "\(trimCountryCode)\(trimNumber)"
        pushToPassword = true
    }
    
    var filteredResorts: [CPData] {
        if searchCountry.isEmpty {
            return countries
        } else {
            return countries.filter { $0.name.contains(searchCountry) }
        }
    }
}

#Preview {
    PhoneNumberView()
        .preferredColorScheme(.dark)
}
