//
//  MatchedGeometryEffectBootcamp2.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 08/05/2023.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp2: View {
    
    let categories: [String] = ["Breakfast", "Launch", "Dinner"]
    @State var selected: String = "Breakfast"
    @Namespace private var namespace
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack(alignment: .bottom) {
                    if selected == category {
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(.green)
                            .matchedGeometryEffect(id: "", in: namespace)
                            .frame(width: 58, height: 2)
                    }
                    
                    Text(category)
                        .font(.subheadline)
                        .foregroundColor(selected == category ? .green : .black)
                        .padding(.bottom, 3)
                }
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
}

struct MatchedGeometryEffectBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectBootcamp2()
    }
}
