//
//  SearchableView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 19/06/2023.
//

import SwiftUI
import Combine

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
    
    @Published private(set) var allRestaurants: [Restaurant] = []
    @Published private(set) var filterRestaurants: [Restaurant] = []
    @Published var searchText: String = ""
    
    let restaurantManager = RestaurantManager()
    private var cancellable = Set<AnyCancellable>()
    var isSearching : Bool {
        !searchText.isEmpty
    }
    
    init() {
        addSubscriber()
    }
    
    func loadRestaurants() async {
        do {
            allRestaurants = try await restaurantManager.fetchAllRestaurant()
        } catch {
            print(error)
        }
    }
    
    func addSubscriber() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { searchText in
                self.filterRestaurants(searchText: searchText)
            }
            .store(in: &cancellable)
    }
    
    func filterRestaurants(searchText: String) {
        guard !searchText.isEmpty else {
            filterRestaurants = []
            return
        }
        
        let search = searchText.lowercased()
        
        filterRestaurants = allRestaurants.filter { restaurant in
            let titleContainsSearch = restaurant.title.lowercased().contains(search)
            let cityContainsSearch = restaurant.city.rawValue.lowercased().contains(search)
            
            return titleContainsSearch || cityContainsSearch
        }
    }
}

struct SearchableView: View {
    
    @StateObject private var vm = SearchableViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(vm.isSearching ? vm.filterRestaurants : vm.allRestaurants) { restaurant in
                        restaurantRow(restaurant: restaurant)
                    }
                }
                .padding()
            }
            .searchable(text: $vm.searchText, placement: .automatic, prompt: "Search Restaurant..")
            .task {
                await vm.loadRestaurants()
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
