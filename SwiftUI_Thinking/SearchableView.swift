//
//  SearchableView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 19/06/2023.
//

import SwiftUI

enum City: String {
    case american
    case italian
    case laos
    case vietnam
}

struct Restaurant: Identifiable, Hashable {
    var id = UUID().uuidString
    var title: String
    var city: City
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + city.hashValue.description)
    }
}

class RestaurantManager {
    
    func fetchAllRestaurant() async throws -> [Restaurant] {
        [
            Restaurant(title: "Hamburger", city: .american),
            Restaurant(title: "Noodle", city: .italian),
            Restaurant(title: "Cari", city: .laos),
            Restaurant(title: "Pho", city: .vietnam),
            Restaurant(title: "Banh Mi", city: .vietnam),
        ]
    }
}

@MainActor
class SearchableViewModel: ObservableObject {
    
    @Published private(set) var foods: [Restaurant] = []
    var searchFood = RestaurantManager()
    
    func fetchFood() async {
        do {
            foods = try await searchFood.fetchAllRestaurant()
        } catch {
            print(error)
        }
    }
}

struct SearchableView: View {
    
    @StateObject private var vm = SearchableViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(vm.foods) { restaurant in
                        restaurantRow(restaurant: restaurant)
                    }
                }
                .padding()
            }
            .task {
                await vm.fetchFood()
            }
            .navigationTitle("Restaurant..")
        }
    }
    
    func restaurantRow(restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(restaurant.title)
                .font(.headline)
            Text(restaurant.city.rawValue)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.05))
        }
    }
}

struct SearchableView_Previews: PreviewProvider {
    static var previews: some View {
        SearchableView()
    }
}
