import SwiftUI

struct LoginView: View {
    var onLogin: () -> Void

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack(alignment: .center, spacing: 60) {
            Text("Login")
                .font(.system(size: 40, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.1, green: 0.08, blue: 0.14))
                .frame(maxWidth: .infinity, alignment: .top)

            VStack(alignment: .center, spacing: 30) {
                VStack(alignment: .trailing, spacing: 12) {
                    inputField(title: "Correo", text: $email, placeholder: "Ingresa tu correo", isSecure: false)
                    inputField(title: "Contraseña", text: $password, placeholder: "Ingresa tu contraseña", isSecure: true)

                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .topTrailing)

                Button(action: handleLogin) {
                    HStack(alignment: .center, spacing: 8) {
                        Text("Inicia sesión")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(red: 1, green: 0.29, blue: 0.2))
                    .cornerRadius(Constants.RadiusFull)
                }
            }
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .top)
    }

    private func handleLogin() {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedEmail.isEmpty && trimmedPassword.isEmpty {
            errorMessage = "Necesitas ingresar tus datos."
        } else if trimmedEmail.isEmpty {
            errorMessage = "Falta el correo electrónico."
        } else if trimmedPassword.isEmpty {
            errorMessage = "Falta la contraseña."
        } else if trimmedEmail.lowercased() == "maruca@arca.mx" && trimmedPassword == "Temporal123!" {
            errorMessage = nil
            onLogin()
        } else {
            errorMessage = "Correo o contraseña incorrectos."
        }
    }

    @ViewBuilder
    private func inputField(title: String, text: Binding<String>, placeholder: String, isSecure: Bool) -> some View {
        VStack(alignment: .trailing, spacing: 6) {
            HStack(alignment: .center, spacing: 6) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .kerning(0.14)
                    .foregroundColor(Color(red: 0.1, green: 0.08, blue: 0.14))
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(alignment: .center, spacing: 8) {
                if isSecure {
                    SecureField("", text: text, prompt: Text(placeholder)
                        .font(.system(size: 14))
                        .kerning(0.14)
                        .foregroundColor(Constants.NeutralN400))
                } else {
                    TextField("", text: text, prompt: Text(placeholder)
                        .font(.system(size: 14))
                        .kerning(0.14)
                        .foregroundColor(Constants.NeutralN400))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Constants.ShadeWhite)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.75)
                    .stroke(Constants.NeutralN200, lineWidth: 1.5)
            )
        }
    }
}

struct Constants {
    static let ShadeWhite: Color = .white
    static let NeutralN200: Color = Color(red: 0.89, green: 0.91, blue: 0.94)
    static let NeutralN400: Color = Color(red: 0.58, green: 0.64, blue: 0.72)
    static let RadiusFull: CGFloat = 9999
}

#Preview {
    LoginView(onLogin: {})
}
