//
//  Pool.swift
//  Pollexa
//
//  Created by Eda Bulut on 8.06.2024.
//

import Foundation

struct Poll {
    let id: UUID
    let user: User
    let question: String
    var options: [Option]
    var lastVoted: String
    let initTime: String
    var totalVotes: Int
    var didVote: Bool
}
