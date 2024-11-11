import SwiftUI

struct ExpenseView: View {
    @State private var expenses: [Expense] = []
    @State private var expenseName = ""
    @State private var expenseAmount = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List(expenses, id: \.name) { expense in
                    HStack {
                        Text(expense.name)
                        Spacer()
                        Text("$\(expense.amount, specifier: "%.2f")")
                    }
                }
                
                HStack {
                    TextField("Expense name", text: $expenseName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Amount", text: $expenseAmount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addExpense) {
                        Text("Add")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle("Expenses")
            .onAppear {
                DataManager.shared.loadExpenses { loadedExpenses in
                    self.expenses = loadedExpenses
                }
            }
        }
    }
    
    private func addExpense() {
        if let amount = Double(expenseAmount), !expenseName.isEmpty {
            let newExpense = Expense(name: expenseName, amount: amount)
            expenses.append(newExpense)
            DataManager.shared.saveExpenses(expenses)
            Logger.shared.log("Added expense: \(expenseName) - $\(amount)")
            expenseName = ""
            expenseAmount = ""
        }
    }
}
