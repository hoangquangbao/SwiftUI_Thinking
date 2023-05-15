//
//  UIViewPresentableView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 12/05/2023.
//

import SwiftUI

struct UIViewPresentableView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            UITextFieldViewRepresentable()
                .frame(height: 55)
                .padding(.horizontal, 5)
                .fontWeight(.bold)
                .background(.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
        }
    }
}

struct UIViewPresentableView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPresentableView()
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return uiTextFieldView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    private func uiTextFieldView() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeholder = NSAttributedString(string: "Type here...",
                                             attributes: [.foregroundColor: UIColor.gray])
        textField.attributedPlaceholder = placeholder
        return textField
    }
}
