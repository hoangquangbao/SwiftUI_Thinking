//
//  MatchedGeometryEffectBootcamp3.swift
//  SwiftUI_Thinking
//
//  Created by Bao Hoang on 16/6/24.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp3: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { int in
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: agreeCaculator(geo: geo) * 30),
                                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading, spacing: 20, content: {
                            Text("\(geo.frame(in: .global).minX)")
                                .foregroundStyle(.yellow)
                            
                            Text("\(geo.frame(in: .global).maxX)")
                                .foregroundStyle(.red)
                        })
                        .padding()
                    }
                    .frame(width: 250, height: 200)
                    .padding()
                }
            }
        }
    }
    
    private func agreeCaculator(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        
        return Double(1 - (currentX / maxDistance))
    }
}

#Preview {
    MatchedGeometryEffectBootcamp3()
}
