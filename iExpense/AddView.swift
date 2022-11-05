//
//  AddView.swift
//  iExpense
//
//  Created by Benjamin Heflin on 11/4/22.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = Locale.current.currencyCode!
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertShowing = false
    
    
    let types = ["Business", "Personal"]
    let currencies = Locale.commonISOCurrencyCodes
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                HStack (alignment: .lastTextBaseline){
                    Picker("Currency", selection: $currency) {
                        ForEach(currencies, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    saveItem()
                }
            }
            .alert(alertTitle, isPresented: $alertShowing) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func saveItem() {
        if name == "" {
            alertTitle = "Missing Name"
            alertMessage = "Please include a name with your expense"
            alertShowing = true
        }
        
        else if amount <= 0 {
            alertTitle = "Invalid Amout"
            alertMessage = "Please enter a valid expense amount"
            alertShowing = true
        }
        
        else if currency == "" {
            alertTitle = "Currency Not Selected"
            alertMessage = "Please select a currency for your expense"
            alertShowing = true
        }
        
        else {
            let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
            expenses.items.append(item)
            dismiss()
        }
    
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
