//
//  MockDataService.swift
//  Pollexa
//
//  Created by Eda Bulut on 8.06.2024.
//

import UIKit
import Combine

class MockDataService {
    func fetchPolls() -> AnyPublisher<[Poll], Never> {
        let user1 = User(id: UUID(), name: "Lisa Bryant", profileImage: UIImage(named: "lisa")!)
        let user2 = User(id: UUID(), name: "John Smith", profileImage: UIImage(named: "john")!)

        let optionImage1 = UIImage(named: "option1")!
        let optionImage2 = UIImage(named: "option2")!
        let optionImage3 = UIImage(named: "option3")!
        let optionImage4 = UIImage(named: "option4")!
        
        let option1 = Option(id: UUID(), text: "Perfume A", image: optionImage1, votes: 4, selectedVote: false)
        let option2 = Option(id: UUID(), text: "Perfume B", image: optionImage2, votes: 2, selectedVote: false)
        
        let option3 = Option(id: UUID(), text: "Beach", image: optionImage3, votes: 5, selectedVote: false)
        let option4 = Option(id: UUID(), text: "Mountain", image: optionImage4, votes: 3, selectedVote: false)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let lastVoted1 = formatter.date(from: "2024/05/18 10:00") ?? Date()
        let lastVoted2 = formatter.date(from: "2024/05/17 15:30") ?? Date()
        
        let initTime1 = formatter.date(from: "2024/05/25 10:00") ?? Date()
        let initTime2 = formatter.date(from: "2024/05/24 15:30") ?? Date()

        let poll1 = Poll(
            id: UUID(),
            user: user1,
            question: "I am in the middle of these two perfumes. Which one should I buy?",
            options: [option1, option2],
            lastVoted: timeAgoSinceDate(lastVoted1, caseStyle: .uppercase),
            initTime: timeAgoSinceDate(initTime1, caseStyle: .lowercase),
            totalVotes: 6,
            didVote: false
        )
        let poll2 = Poll(
            id: UUID(),
            user: user2,
            question: "Which way would you choose for your next vacation?",
            options: [option3, option4],
            lastVoted: timeAgoSinceDate(lastVoted2, caseStyle: .uppercase),
            initTime: timeAgoSinceDate(initTime2, caseStyle: .lowercase),
            totalVotes: 8,
            didVote: false
        )

        return Just([poll1, poll2])
            .eraseToAnyPublisher()
    }
}
