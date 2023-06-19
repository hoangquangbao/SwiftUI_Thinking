//
//  RefreshableView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 19/06/2023.
//

import SwiftUI

final class DataManager {
    func fetchData() async throws -> [String] {
        //This command line will delay execute in 5s
        //And "refreshable" will show indicator while hold time
        try await Task.sleep(nanoseconds: 5_000_000_000)
        return ["One", "Two", "Three", "Four"].shuffled()
    }
}

@MainActor
class RefreshableViewModel: ObservableObject {
    
    var dataManager = DataManager()
    
    @Published private(set) var items : [String] = []
    
    func fetchData() async {
        do {
            items = try await dataManager.fetchData()
        } catch {
            print(error)
        }
    }
}

struct RefreshableView: View {
    
    @StateObject var vm = RefreshableViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(vm.items, id: \.self) { item in
                        Text(item)
                            .fontWeight(.bold)
                    }
                }
            }
            .navigationTitle("Nav Stack")
            .refreshable {
                await vm.fetchData()
            }
            .task {
                await vm.fetchData()
            }
        }
    }
}

struct RefreshableView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableView()
    }
}
