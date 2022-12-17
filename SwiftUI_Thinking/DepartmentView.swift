//
//  DepartmentView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 14/12/2022.
//

import SwiftUI

struct DepartmentView: View {
    
    var entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses: ")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                        .font(.system(size: 10))
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .font(.system(size: 14))
        .padding()
        .frame(width: 150, alignment: .leading)
        .background(.orange)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

//struct DepartmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DepartmentView()
//    }
//}
