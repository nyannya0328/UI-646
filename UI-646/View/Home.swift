//
//  Home.swift
//  UI-646
//
//  Created by nyannyan0328 on 2022/08/17.
//

import SwiftUI

struct Home: View {
    @GestureState var statPotition : CGPoint = .zero
    var body: some View {
        GeometryReader{proxy in
            
             let size = proxy.size
            
            let widht = size.width / 10
            
            let itemCount = Int((size.height / widht).rounded() * 10)
            
            let colums = Array(repeating: GridItem(.flexible(),spacing: 0), count: 10)
            
            
            LinearGradient(colors: [.red,.green,.orange,.pink], startPoint: .top, endPoint: .bottom)
                .mask {
                    
                    
                    LazyVGrid(columns: colums,spacing: 0) {
                        
                        
                        ForEach(0..<itemCount,id:\.self){index in
                            
                            
                            GeometryReader{innner in
                                
                                let rect = innner.frame(in: .named("GES"))
                                let scale = itemScale(rect: rect, size: size)
                                
                                let transformedRect = rect.applying(.init(scaleX: scale, y: scale))
                                
                                let transformedLocation = statPotition.applying(.init(scaleX: scale, y: scale))
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.orange)
                                    .scaleEffect(scale)
                                    .offset(x:(transformedRect.midX - rect.midX),y:(transformedRect.minY - rect.midY))
                                    .offset(x:statPotition.x - transformedLocation.x,y:statPotition.y - transformedLocation.y)
                            }
                            .padding(5)
                            .frame(height:widht)
                            
                            
                        }
                    
                    }
                }
        
            
            
           
            
            
            
        }
        .padding(15)
        .gesture(
        
            DragGesture().updating($statPotition, body: { value, out, _ in
                out = value.location
            })
        
        )
        .coordinateSpace(name: "GES")
        .preferredColorScheme(.dark)
    }
    
    func itemScale(rect : CGRect,size : CGSize) -> CGFloat{
        
        
        let a = statPotition.x - rect.midX
        let b = statPotition.y - rect.midY
        
        let root = sqrt((a * a) + (b * b))
        let diagonalValue = sqrt((size.width * size.width) + (size.height * size.height))
       
        let scale = (root - 150) / 150
        
     //   let scale = root / ( diagonalValue / 2)
        
        let modifredScale = statPotition == .zero ? 1 : (1 - scale)
        
        return modifredScale > 0 ? modifredScale : 0.001
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
