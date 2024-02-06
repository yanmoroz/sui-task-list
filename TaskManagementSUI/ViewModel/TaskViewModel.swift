//
//  TaskViewModel.swift
//  TaskManagementSUI
//
//  Created by Yan Moroz on 06.02.2024.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    
    @Published var storedTasks: [Task] = [
        Task(
            title: "Meeting",
            description: "Discuss team task for the day",
            date: .init(timeIntervalSince1970: 1707357257)
        ),
        Task(
            title: "Icon set",
            description: "Edit icons for team task for next week",
            date: .init(timeIntervalSince1970: 1707357257)
        ),
        Task(
            title: "Prototype",
            description: "Make and send prototype",
            date: .init(timeIntervalSince1970: 1707357257)
        ),
        Task(
            title: "Check asset",
            description: "Start checking the assets",
            date: .init(timeIntervalSince1970: 1707237257)
        ),
        Task(
            title: "Team party",
            description: "Make fun with team mates",
            date: .init(timeIntervalSince1970: 1707237257)
        ),
        Task(
            title: "Client Meeting",
            description: "Explain project to clinet",
            date: .init(timeIntervalSince1970: 1707270257)
        ),
        
        Task(
            title: "Next Project",
            description: "Discuss next project with team",
            date: .init(timeIntervalSince1970: 1707270257)
        ),
        Task(
            title: "App Proposal",
            description: "Meet client for next App Proposal",
            date: .init(timeIntervalSince1970: 1707257257)
        )
    ]
    
    @Published var currentWeek: [Date] = []
    @Published var currentDay = Date.now
    @Published var filteredTasks: [Task]?
    
    init() {
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    // MAINACTOR?
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            let filtered = self.storedTasks
                .filter { calendar.isDate($0.date, inSameDayAs: self.currentDay) }
                .sorted { $0.date < $1.date }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek() {
        let today = Date.now
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formetter = DateFormatter()
        formetter.dateFormat = format
        return formetter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    func isCurrentHour(date: Date) -> Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date.now)
        
        return hour == currentHour
    }
}
