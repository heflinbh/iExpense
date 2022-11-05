//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Benjamin Heflin on 11/4/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}
