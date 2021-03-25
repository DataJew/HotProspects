//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Matthew Garlington on 3/19/21.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State var show = false
    let filter: FilterType
    
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
    
    var filterProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        
        ZStack {
      
            AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8472073078, green: 0.4155753255, blue: 0.6355627775, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]), center: .center, angle: .degrees(120))
                .ignoresSafeArea()
            
            Image("Blob4")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .offset(x: -200)
                // Added Rotation for the blob
                .rotationEffect(Angle(degrees:  show ? 360 : 90))
                .blendMode(.softLight)
                // Animation Rotates
                .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                // Triggers the the show variable upon the blob appearing
                .onAppear { self.show = true }
            ZStack {
            
            Image("Blob4")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 200)
                .blendMode(.colorDodge)
                .opacity(0.5)
     
            
            Image("Blob4")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .blendMode(.colorDodge)
                .opacity(0.5)
            }
            
            .offset(x: -150, y: -400)
            
            ZStack {
            
            Image("Blob4")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .blendMode(.luminosity)
                .opacity(0.5)
            
            Image("Blob4")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .blendMode(.luminosity)
                .opacity(0.5)
            }
            .offset(x: -25, y: -150)
           
            ZStack {
            
            Image("Blob4")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .blendMode(.luminosity)
                .opacity(0.5)

            Image("Blob4")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 300)
                .blendMode(.luminosity)
                .opacity(0.5)
            }
            .offset(x: 150, y: 150)

            Image("Blob6")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .offset(x: 100)
                // Added Rotation for the blob
                .rotationEffect(Angle(degrees:  show ? 180 : 90))
                .blendMode(.softLight)
                // Animation Rotates
                .animation(Animation.linear(duration: 50).repeatForever(autoreverses: true))
                // Triggers the the show variable upon the blob appearing
                .onAppear { self.show = true }
            

              
            
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.1), Color.black.opacity(0.3)]), startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            
          

             
            VStack {
                
                HStack {
                    Text(title)
                        .foregroundColor(Color(#colorLiteral(red: 0.939720273, green: 0.9341338873, blue: 0.9440143108, alpha: 0.7337800083)))
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Button(action: {
                        self.isShowingScanner = true
                    }, label: {
                        Image(systemName: "qrcode.viewfinder")
                            .font(.largeTitle)
                        
                        Text("Scan")
                            .bold()
                    })
                    
                    .foregroundColor(Color(#colorLiteral(red: 0.939720273, green: 0.9341338873, blue: 0.9440143108, alpha: 0.7337800083)))
                    .padding()
                    .sheet(isPresented: $isShowingScanner) {
                        
                        CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
                    }
                }
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(filterProspects) { prospect in
                            
                            ZStack {
                                Spacer()
                                    .frame(width: 400, height: 75)
                                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0.3, y: 0.2)
                                    .background(Color.black.opacity(0.4))
                                    .background(Color.white.opacity(0.3))
                                    .cornerRadius(15)
                                    .border(Color.purple, width: 2)
                                    .cornerRadius(5)
                             
                                
                                  
                                HStack(spacing: 40) {
                                    Spacer()
                                        .frame(width: 50, height: 50)
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(Circle())
                                    
                                    
                                    VStack(alignment: .leading) {
                                        
                                        Text(prospect.name)
//                                            .foregroundColor(.white)
                                            .gradientForeground(colors: [Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.6345303059, blue: 0.992546618, alpha: 1))])
                                            .font(.headline)
                                        Text(prospect.emailAddress)
                                            .foregroundColor(.gray)
                                        
                                    }
                                }
                            }
                            .contextMenu {
                                Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                                    // This calls the created function in Prospect class to send the change to other views
                                    self.prospects.toggle(prospect)
                                }
                                if !prospect.isContacted {
                                    Button("Remind Me") {
                                        self.addNotification(for: prospect)
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning failed")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            //            var dateComponents = DateComponents()
            //            dateComponents.hour = 9
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
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
                        print("Doh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects.init())
    }
}


struct BlurView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    var style: UIBlurEffect.Style
 
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        // adding the style variable makes the blur style customizable
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
       
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}

