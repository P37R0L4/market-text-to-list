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
    @State var countryCode : String = "+55"
    @State var mobPhoneNumber: String = ""
    @State var countryFlag : String = "🇧🇷"
    @State var countryPattern : String = "## # ### ####"
    @State var countryLimit : Int = 17
    @State private var searchCountry: String = ""
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var keyIsFocused: Bool
    
    @Binding var completePhoneNumber: String
    @Binding var pushToPassword: Bool = false
    
    let counrties: [CPData] = Bundle.main.decode("CountryNumbers.json")
    
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
                            keyIsFocused = false
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
                            .focused($keyIsFocused)
                            .keyboardType(.phonePad)
                            .onReceive(Just(mobPhoneNumber)) { _ in
                                applyPatternOnNumbers(&mobPhoneNumber, pattern: countryPattern, replacementCharacter: "#")
                            }
                            .padding(10)
                            .frame(minWidth: 80, minHeight: 47)
                            .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 15)
                    
                    Button {
                        buttonAction()
                    } label: {
                        Text("Next")
                    }
                    .disableWithOpacity(mobPhoneNumber.count < 1)
                    .buttonStyle(OnboardingButtonStyle())
                }
                .animation(.easeInOut(duration: 0.6), value: keyIsFocused)
                .padding(.horizontal)
                
                Spacer()
            }
            .onTapGesture {
                hideKeyboard()
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
            return counrties
        } else {
            return counrties.filter { $0.name.contains(searchCountry) }
        }
    }
    
    var backgroundColor: Color {
        if colorScheme == .dark {
            return Color(.systemGray5)
        } else {
            return Color(.systemGray6)
        }
    }
    
    func applyPatternOnNumbers(_ stringvar: inout String, pattern: String, replacementCharacter: Character) {
        var pureNumber = stringvar.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else {
                stringvar = pureNumber
                return
            }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        stringvar = pureNumber
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(
            countryCode: "+55",
            countryFlag: "🇧🇷",
            countryPattern: "## # #### ####",
            countryLimit: 17,
            completePhoneNumber: .constant("")
        )
        .preferredColorScheme(.dark)
        
        PhoneNumberView(
            countryCode: "+55",
            countryFlag: "🇧🇷",
            countryPattern: "## # #### ####",
            countryLimit: 17,
            completePhoneNumber: .constant("")
        )
        .preferredColorScheme(.light)
    }
}