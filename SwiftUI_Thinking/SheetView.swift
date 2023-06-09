//
//  SheetView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 09/06/2023.
//

import SwiftUI

struct SheetView: View {
    
    @State var isShowSheet: Bool = false
    
    var body: some View {
        Button {
            isShowSheet = true
        } label: {
            Text("Show Sheet")
        }
        .sheet(isPresented: $isShowSheet) {
            Text("Sheet screen")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.orange)
//                .presentationDragIndicator(.hidden)
//                .interactiveDismissDisabled(true)
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
