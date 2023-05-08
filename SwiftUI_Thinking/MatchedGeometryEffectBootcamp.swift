//
//  MatchedGeometryEffectBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 08/05/2023.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    
    @State var isClick: Bool = false
    @Namespace var namespace
    var body: some View {
        VStack {
            if isClick {
                Circle()
                    .matchedGeometryEffect(id: "", in: namespace)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            if !isClick {
                Circle()
                    .matchedGeometryEffect(id: "", in: namespace)
                    .frame(width: 300, height: 300)
                    .foregroundColor(.green)
            }
        }
        .frame(maxWidth: .infinity)
        .background(.black.opacity(0.3))
        .onTapGesture {
            withAnimation(Animation.easeInOut(duration: 1)) {
                isClick.toggle()
            }
        }
    }
}

struct MatchedGeometryEffectBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectBootcamp()
    }
}
