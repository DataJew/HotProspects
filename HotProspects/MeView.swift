//
//  MeView.swift
//  HotProspects
//
//  Created by Matthew Garlington on 3/19/21.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
   
    var body: some View {
        NavigationView {
            
            ZStack {
                Spacer()
                AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8472073078, green: 0.4155753255, blue: 0.6355627775, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]), center: .center, angle: .degrees(120))
                    .ignoresSafeArea()
                
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title)
                        .padding(.horizontal)
                    
                    TextField("Email Address", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .font(.title)
                        .padding([.horizontal, .bottom])
                    Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0.0, y: 0.0)
                    
                    Spacer()
                    
                }
                .navigationBarTitle("Your code")
            }
        }
    }
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
                
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
