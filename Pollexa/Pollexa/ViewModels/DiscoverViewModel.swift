//
//  DiscoverViewModel.swift
//  Pollexa
//
//  Created by Eda Bulut on 8.06.2024.
//

import Foundation
import Combine

class DiscoverViewModel: ObservableObject {
    @Published var polls: [Poll] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService: MockDataService
    
    init(dataService: MockDataService) {
        self.dataService = dataService
        self.fetchPolls()
    }
    
    func fetchPolls() {
        dataService.fetchPolls()
            .sink { [weak self] polls in
                self?.polls = polls
            }
            .store(in: &cancellables)
    }
}
