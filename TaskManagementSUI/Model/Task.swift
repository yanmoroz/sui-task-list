//
//  Task.swift
//  TaskManagementSUI
//
//  Created by Yan Moroz on 06.02.2024.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var date: Date
}
