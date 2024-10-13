//
//  NavigationSplitViewBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Bao Hoang on 13/10/24.
//

import SwiftUI
// Using for iPad, MacOS, VisionOS
//MARK: - Original
/*
struct NavigationSplitViewBootcamp: View {
    
    @State var columnVisibility: NavigationSplitViewVisibility = .all
    @State var selectedCategory: FoodCatergory?
    @State var selectedDrink: Drinks?
    @State var selectedDessert: Desserts?
    @State var selectedSnack: Snacks?
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List {
                ForEach(FoodCatergory.allCases, id: \.rawValue) { category in
                    Button {
                        selectedCategory = category
                    } label: {
                        Text(category.rawValue)
                            .bold()
                    }
                }
            }
            .navigationTitle("Foot Catergories")
        } content: {
            if let selectedCategory {
                switch selectedCategory {
                case .Drinks:
                    List {
                        ForEach(Drinks.allCases, id: \.rawValue) { drink in
                            Button {
                                selectedDrink = drink
                            } label: {
                                Text(drink.rawValue)
                                    .bold()
                            }
                        }
                    }
                    .navigationTitle(selectedCategory.rawValue.capitalized)
                case .Desserts:
                    List {
                        ForEach(Desserts.allCases, id: \.rawValue) { dessert in
                            Button {
                                selectedDessert = dessert
                            } label: {
                                Text(dessert.rawValue)
                                    .bold()
                            }
                        }
                    }
                    .navigationTitle(selectedCategory.rawValue.capitalized)
                case .Snacks:
                    List {
                        ForEach(Snacks.allCases, id: \.rawValue) { snack in
                            Button {
                                selectedSnack = snack
                            } label: {
                                Text(snack.rawValue)
                                    .bold()
                            }
                        }
                    }
                    .navigationTitle(selectedCategory.rawValue.capitalized)
                }
            } else {
                Text("Select a category")
            }
        } detail: {
            switch selectedCategory {
            case .Drinks:
                DrinkDetailView(drink: selectedDrink)
            case .Desserts:
                DessertDetailView(dessert: selectedDessert)
            case .Snacks:
                SnackDetailView(snack: selectedSnack)
            case .none:
                Text("Something!!!")
            }
        }
    }
}

struct DrinkDetailView: View {
    
    var drink: Drinks?
    
    var body: some View {
        VStack {
            Text(drink?.rawValue ?? "Something about drinks!!!")
        }
    }
}

struct DessertDetailView: View {
    
    var dessert: Desserts?
    
    var body: some View {
        VStack {
            Text(dessert?.rawValue ?? "Something about desserts!!!")
        }
    }
}

struct SnackDetailView: View {
    var snack: Snacks?
    
    var body: some View {
        VStack {
            Text(snack?.rawValue ?? "Something about snacks!!!")
        }
    }
}

#Preview {
    NavigationSplitViewBootcamp()
}

enum FoodCatergory: String, CaseIterable {
    case Drinks, Desserts, Snacks
}

enum Drinks: String, CaseIterable {
    case OrangeJuice, AppleJuice, LemonJuice, Water, Tea, Coffee, Milk, Juice, Soda
}

enum Desserts: String, CaseIterable {
    case Cake, Pie, Pastry, IceCream, Cookies, Chocolate
}

enum Snacks: String, CaseIterable {
    case Chips, Crackers, Pretzels, Popcorn, Nuts, Fruit
}
*/


//MARK: - Improved
struct NavigationSplitViewBootcamp: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selectedCategory: FoodCategory?
    @State private var selectedDrink: Drinks?
    @State private var selectedDessert: Desserts?
    @State private var selectedSnack: Snacks?
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(FoodCategory.allCases, id: \.self, selection: $selectedCategory) { category in
                Text(category.rawValue.capitalized)
            }
            .navigationTitle("Food Categories")
        } content: {
            if let selectedCategory {
                ItemList(category: selectedCategory,
                         selectedDrink: $selectedDrink,
                         selectedDessert: $selectedDessert,
                         selectedSnack: $selectedSnack)
            } else {
                Text("Select a category")
            }
        } detail: {
            DetailView(category: selectedCategory,
                       drink: selectedDrink,
                       dessert: selectedDessert,
                       snack: selectedSnack)
        }
    }
}

struct ItemList: View {
    let category: FoodCategory
    @Binding var selectedDrink: Drinks?
    @Binding var selectedDessert: Desserts?
    @Binding var selectedSnack: Snacks?
    
    var body: some View {
        Group {
            switch category {
            case .drinks:
                List(Drinks.allCases, id: \.self, selection: $selectedDrink) { drink in
                    Text(drink.rawValue.capitalized)
                }
            case .desserts:
                List(Desserts.allCases, id: \.self, selection: $selectedDessert) { dessert in
                    Text(dessert.rawValue.capitalized)
                }
            case .snacks:
                List(Snacks.allCases, id: \.self, selection: $selectedSnack) { snack in
                    Text(snack.rawValue.capitalized)
                }
            }
        }
        .navigationTitle(category.rawValue.capitalized)
    }
}

struct DetailView: View {
    let category: FoodCategory?
    let drink: Drinks?
    let dessert: Desserts?
    let snack: Snacks?
    
    var body: some View {
        if let category {
            Group {
                switch category {
                case .drinks:
                    Text(drink?.rawValue.capitalized ?? "Select a drink")
                        .navigationTitle(drink?.rawValue.capitalized ?? "")
                case .desserts:
                    Text(dessert?.rawValue.capitalized ?? "Select a dessert")
                        .navigationTitle(dessert?.rawValue.capitalized ?? "")
                case .snacks:
                    Text(snack?.rawValue.capitalized ?? "Select a snack")
                        .navigationTitle(snack?.rawValue.capitalized ?? "")
                }
            }
        } else {
            Text("Something!!!")
        }
    }
}

enum FoodCategory: String, CaseIterable {
    case drinks, desserts, snacks
}

enum Drinks: String, CaseIterable {
    case orangeJuice, appleJuice, lemonJuice, water, tea, coffee, milk, juice, soda
}

enum Desserts: String, CaseIterable {
    case cake, pie, pastry, iceCream, cookies, chocolate
}

enum Snacks: String, CaseIterable {
    case chips, crackers, pretzels, popcorn, nuts, fruit
}

#Preview {
    NavigationSplitViewBootcamp()
}
