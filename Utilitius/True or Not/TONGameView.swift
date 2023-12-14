//import SwiftUI
//
//struct TONGameView: View {
//    let count1 = Fascisme.allCases.count
//    let count2 = NationaalSocialisme.allCases.count
//    
//    @State var randomKenmerk = (caseName: "", rawValue: "")
//    @State private var lastRandomEnumWasFascisme = false
//    @State private var isCorrect: Bool? = nil
//    
//    var body: some View {
//        VStack {
//            Button("Start") {
//                randomKenmerk = getRandomItemFromRandomEnum()
//            }
//            .padding()
//            .foregroundStyle(.white)
//            .background(.blue, in: .capsule)
//            .padding()
//            
//            Text(randomKenmerk.1.replacingOccurrences(of: "_", with: " "))
//                .title(.semibold)
//            
//            Text(randomKenmerk.0)
//                .title3(.semibold)
//                .padding(.top)
//            
//            if let isCorrect {
//                Text(isCorrect ? "Correct!" : "Incorrect.")
//                    .title()
//                    .foregroundStyle(isCorrect ? .green : .red)
//                    .padding()
//            }
//            
//            Spacer()
//            
//            HStack {
//                Button("Fascistisch") {
//                    checkAnswer(isFascistisch: true)
//                }
//                
//                Spacer()
//                
//                Button("Nationaal-Socialistisch") {
//                    checkAnswer(isFascistisch: false)
//                }
//            }
//        }
//        .multilineTextAlignment(.center)
//        .padding()
//    }
//    
//    func checkAnswer(isFascistisch: Bool) {
//        isCorrect = isFascistisch == lastRandomEnumWasFascisme
//        randomKenmerk = getRandomItemFromRandomEnum()
//    }
//    
//    func getRandomItemFromRandomEnum() -> (caseName: String, rawValue: String) {
//        let randomEnum = Bool.random()
//        lastRandomEnumWasFascisme = randomEnum
//        
//        if randomEnum {
//            if let randomCase = Fascisme.allCases.randomElement() {
//                return (caseName: randomCase.rawValue, rawValue: "\(randomCase)")
//            }
//        } else {
//            if let randomCase = NationaalSocialisme.allCases.randomElement() {
//                return (caseName: randomCase.rawValue, rawValue: "\(randomCase)")
//            }
//        }
//        
//        return (caseName: "", rawValue: "") // Fallback
//    }
//}
//
//enum Fascisme: String, CaseIterable {
//    case Totalitarisme = "Volledige controle over alle aspecten van een land (politiek, economie, onderwijs, religie)"
//    case Ondergeschikte_rol_van_vrouwen = "Voornamelijk gericht op kinderopvoeding"
//    case Daad_en_Geweld = "Actie boven dialoog; verandering door daadkracht"
//    case Militarisme = "Geloof in een sterke militaire macht om doelen te bereiken"
//    case Massaorganisatie = "Gebruik van massamedia en propaganda om de publieke opinie te beïnvloeden"
//}
//
//enum NationaalSocialisme: String, CaseIterable {
//    case Rassenleer = "Ariers - hoogwaardig, Slavische mensen - minderwaardig, joden - verderfelijk"
//    case Volksgemeenschap = "Afwijzing van individualisme"
//    case Lebensraum = "Streven naar een verenigd Duits rijk"
//    case Culturele_Superioriteit = "Blanken bereikten hoge cultuur door strijd"
//    case Leidersbeginsel = "Antidemocratisch; beslissingen liggen bij de leider"
//    case Nationalisme = "Eigen groep heeft voorrang"
//    case Ongelijkwaardigheid = "Mensen zijn van nature ongelijk"
//    case Gevoel_Boven_Verstand = "De leider heeft altijd gelijk"
//    case Tegenstand = "Tegen socialisme, communisme, internationalisme en pacifisme"
//}
//
//#Preview {
//    TONGameView()
//}
