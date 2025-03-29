//
//  ViewBuilderBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Bao Hoang on 29/3/25.
//

import SwiftUI

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            HeaderViewGeneric(content: Text("Generic Content"))
            
            //Define like V/HStack
            HeaderViewGenericOne {
                Text("Generic Content")
            }
            HeaderView
        }
    }
    
    @ViewBuilder private var HeaderView: some View {
        viewOne
        viewTwo
    }
    
    private var viewOne: some View {
        Text("View One")
    }
    
    private var viewTwo: some View {
        Text("View Two")
    }
}

struct HeaderViewGeneric<Content: View>: View {
    let content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            content
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct HeaderViewGenericOne<Content: View>: View {
    let content: Content
/*
 init(@ViewBuilder content: () -> Content)
 OR
 init(content: () -> Content)
*/
    init(content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    ViewBuilderBootcamp()
}
