//
//  ExpenseSection.swift
//  iExpense
//
//  Created by Benjamin Heflin on 11/4/22.
//

import SwiftUI

struct ExpenseSection: View {
    
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack (alignment: .leading){
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: item.currency))
                        .foregroundColor(colorExpense(item: item))
                }
                
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    func colorExpense(item: ExpenseItem) -> Color {
        let valueToUSD = [
            "GBP": 1.14,
            "CZK": 0.04,
            "EUR": 0.99,
            "USD": 1.00
        ]
        
        let usdAmount = (valueToUSD[item.currency] ?? 0.0) * item.amount
        
        if usdAmount == 0 {
            return Color.primary
        }
        
        if usdAmount <= 10 {
            return Color.green
        }
        if usdAmount <= 100 {
            return Color.yellow
        }
        return Color.red
    }
}

struct ExpenseSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSection(title: "Example", expenses: []) { _ in
            
        }
    }
}
