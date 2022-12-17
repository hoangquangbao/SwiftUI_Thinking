//
//  EmployeeView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 14/12/2022.
//

import SwiftUI

struct EmployeeView: View {
    
    var entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            Text("Age: \(entity.age)")
                .bold()
            
            Text("Date joined: \(entity.dateJoined ?? Date())")
                .bold()
            
            Text("Business:")
                .bold()
            
            Text(entity.businesses?.name ?? "")
            
            Text("Department:")
                .bold()
            
            Text(entity.departments?.name ?? "")
        }
        .font(.system(size: 14))
        .padding()
        .frame(width: 150, alignment: .leading)
        .background(.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

//struct EmployeeView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmployeeView()
//    }
//}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
