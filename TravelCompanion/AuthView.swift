import SwiftUI
import Firebase
import FirebaseAuth

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var errorMessage = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack {
            Text(isRegistering ? "Register" : "Login")
                .font(.largeTitle)
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: isRegistering ? register : login) {
                Text(isRegistering ? "Register" : "Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            Button(action: {
                isRegistering.toggle()
            }) {
                Text(isRegistering ? "Already have an account? Login" : "Don’t have an account? Register")
                    .foregroundColor(.blue)
                    .padding()
            }

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $isLoggedIn) {
            MainAppView()
        }
    }
    
    // MARK: - Firebase Authentication Functions

    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = "Error: \(error.localizedDescription)"
            } else if let user = result?.user {
                DataManager.shared.setUserId(user.uid)
                isLoggedIn = true
            }
        }
    }

    private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = "Error: \(error.localizedDescription)"
            } else if let user = result?.user {
                DataManager.shared.setUserId(user.uid)
                isLoggedIn = true
            }
        }
    }
}
