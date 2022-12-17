//
//  BussinessView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 14/12/2022.
//

import SwiftUI

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments: ")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
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
        .padding()
        .frame(width: 150, alignment: .leading)
        .foregroundColor(.white)
        .font(.system(size: 14))
        .background(.purple)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
//
//struct BusinessView_Previews: PreviewProvider {
//    static var previews: some View {
//        BussinessView(entity: <#BusinessEntity#>)
//    }
//}
