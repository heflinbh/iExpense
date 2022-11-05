//
//  ContentView.swift
//  iExpense
//
//  Created by Benjamin Heflin on 11/3/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddExpenses = false
    
    var body: some View {
        NavigationView {
            List {
                ExpenseSection(title: "Business", expenses: expenses.businessItems, deleteItems: removeBusinessItems)
                ExpenseSection(title: "Personal", expenses: expenses.personalItems, deleteItems: removePersonalItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpenses = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpenses) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
