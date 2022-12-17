//
//  CoreDataBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 13/12/2022.
//

import SwiftUI
import CoreData

// 3 entities
// BusinessEntity
// DepartmentEntity
// EmployeeEntity

class CoreDataManager {
    
    static var instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading CoreDate: \(error)")
            }
        }
        
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Save succesfully!")
        } catch {
            print("Error saving CoreDate: \(error.localizedDescription)")
        }
    }
}

class CoreDataBootcampViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employeees: [EmployeeEntity] = []
    
    init() {
        getBusiness()
        getDepartment()
        getEmployee()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Orange"
        
        //add existing departments to new business
        //newBusiness.deparments = []
        
        // add existing employees to new business
        //newBusiness.employees = []
        
        // add existing business to new departments
        //newBusiness.addToDeparments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add existing business to new employees
        //newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Software"
//        newDepartment.businesses = [businesses[0]]
        newDepartment.addToEmployees(employeees[4])
        
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Emi"
        newEmployee.age = 22
        newEmployee.dateJoined = Date()
//        newEmployee.businesses = businesses[0]
//        newEmployee.departments = departments[2]
        
        save()
    }
    
    func updateBusiness() {
        let existingBusiness = businesses[1]
        existingBusiness.addToDepartments(departments[2])
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employeees.removeAll()
        
        //Phải có deadline nó mới đồng bộ realtime, chưa hiểu vì sao???
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusiness()
            self.getDepartment()
            self.getEmployee()
        }
    }
    
    func getBusiness() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getDepartment() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getEmployee() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employeees = try manager.context.fetch(request)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataBootcampViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
//                        vm.addBusiness()
//                        vm.addDepartment()
//                        vm.addEmployee()
                        vm.updateBusiness()
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        ForEach(vm.businesses) { business in
                            BusinessView(entity: business)
                        }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        ForEach(vm.departments) { department in
                            DepartmentView(entity: department)
                        }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        ForEach(vm.employeees) { employee in
                            EmployeeView(entity: employee)
                        }
                    }
                }
            }
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
