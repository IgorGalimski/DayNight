//
//  ContentView.swift
//  DayAndNight
//
//  Created by Yasser Farahi.
//

import SwiftUI

struct ContentView: View {
    
    let screenSize = UIScreen.main.bounds
    @State var animationIsRunning: Bool = false
    @State var mainButtonScale: Bool = false
    @State var shouldExpandView: Bool = false
    
    @State var shouldAnimateAirPlane: Bool = false
    
    @State var starOpacity: Double = .zero
    
    let starsPosition : [CGPoint] = [CGPoint(x: 50, y: 50),
    CGPoint(x: 150, y: 20), CGPoint(x: 300, y: 100),
    CGPoint(x: 200, y: 200), CGPoint(x: 75, y: 250),
    CGPoint(x: 270, y: 300), CGPoint(x: 85, y: 150),
    CGPoint(x: 200, y: 75)]
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.111458107, green: 0.3016932569, blue: 0.6905121164, alpha: 1)), Color(#colorLiteral(red: 0.401974672, green: 0.6777534752, blue: 0.9386683199, alpha: 1)), Color(#colorLiteral(red: 0.8872413242, green: 0.78621615, blue: 0.5285315797, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 20, content: {
                
                Image(systemName: "sun.max.fill")
                    .font(.system(size: 200))
                    .scaleEffect( shouldExpandView ? 0.5 : 1.0)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.7164769159, blue: 0.174235057, alpha: 1)))
                    .rotationEffect(.degrees(shouldExpandView ? 360 : 0))
                    .opacity(shouldExpandView ? .zero : 1)
                Text("good morning")
                    .font(.system(size: 35, weight: .thin, design: .default))
                    .opacity(shouldExpandView ? .zero : 1)
            }) 
            Image(systemName: "airplane")
                .font(.system(size: 35))
                .foregroundColor(.white)
                .rotationEffect(.degrees(shouldAnimateAirPlane ? -55 : -40), anchor: .bottom)
                .offset(x: shouldAnimateAirPlane ? screenSize.width - 50 : -screenSize.width + 160, y: shouldAnimateAirPlane ? -screenSize.height + 200 : .zero)
            //MARK: End Of Day View
            //MARK: Start Of The Night View
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2774810863, green: 0.153272489, blue: 0.4317114637, alpha: 1)), Color(#colorLiteral(red: 0.4314404429, green: 0.2871394866, blue: 0.6469875468, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                ForEach(0..<8) { star in
                    
                    Image(systemName: "star.fill")
                        .rotationEffect(.degrees( shouldExpandView ? 360 : .zero), anchor: .center)
                        .scaleEffect(shouldExpandView ? 1.0 : .zero)
                        .opacity(starOpacity)
                        .foregroundColor(.white)
                        .position(starsPosition[star])
                }
                VStack(alignment: .center, spacing: 25, content: {
                    Image(systemName: "moon.fill")
                        .font(.system(size: 200))
                        .scaleEffect(shouldExpandView ? 1.0 : .zero)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(shouldExpandView ? .zero : 180), anchor: .center)
                        .opacity(shouldExpandView ? 1.0 : .zero)
                    
                    Text("good night")
                        .font(.system(size: 35, weight: .thin, design: .default))
                        .foregroundColor(.white)
                        .opacity(shouldExpandView ? 1.0 : .zero)
                })
            }
            .mask(
            
                VStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .scaleEffect( shouldExpandView ? 35 : 0.6)
                            .frame(width: 70, height: 70, alignment: .center)
                    }.padding()
                    
                }
            
            )
            //MARK: End Of Night View
            //MARK: Start of Button View
            
            VStack {
                Spacer()
                ZStack {
                    Circle()
                        .frame(width: 70, height: 70, alignment: .center)
                        .foregroundColor(shouldExpandView ? Color(#colorLiteral(red: 0.4859752171, green: 0.7424323146, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.5149585294, green: 0.3224118821, blue: 1, alpha: 1)))
                        .overlay(
                            Image(systemName: shouldExpandView ? "sun.max.fill" : "moon.stars.fill")
                                .rotationEffect(.degrees(shouldExpandView ? -90 : .zero), anchor: .center)
                                .font(.system(size: 35))
                                .foregroundColor(shouldExpandView ? .yellow : .white)
                                .scaleEffect(mainButtonScale ? 0.1 : 1.0)
                        
                        )
                        .onTapGesture {
                            
                            animationIsRunning.toggle()
                            
                            withAnimation(Animation.easeInOut(duration: 0.2)) {
                                mainButtonScale = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                                
                                withAnimation {
                                    
                                    mainButtonScale = false
                                    
                                }
                                
                                withAnimation(Animation.easeInOut(duration: 2.0)) {
                                    
                                    shouldExpandView.toggle()
                                    starOpacity = shouldExpandView ? 1.0 : .zero
                                    
                                }
                                
                            }
                            
                        }
                    
                }
                
            }.padding()
            .onAppear(perform: {
                withAnimation(Animation.easeIn(duration: 4.0).delay(2.0).repeatForever(autoreverses: false)) {
                    shouldAnimateAirPlane = true
                }
            })
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
