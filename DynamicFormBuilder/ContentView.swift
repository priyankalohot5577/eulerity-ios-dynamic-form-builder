import SwiftUI

struct ContentView: View {
    
    @FocusState private var focusedField: String?
    @State private var showSuccess = false
    @StateObject private var viewModel = FormViewModel()
    private var backgroundColor: Color {

        Color(
            hex: viewModel.form?.theme.backgroundColor
            ?? "#FFFFFF"
        ) ?? .white
    }
    private var textColor: Color {

        Color(
            hex: viewModel.form?.theme.textColor
            ?? "#000000"
        ) ?? .black
    }
    var body: some View {

        Group {

            if let form = viewModel.form {

                ZStack {

                    backgroundColor
                        .ignoresSafeArea()

                    ScrollView {

                        VStack(
                            alignment: .leading,
                            spacing: 16
                        ) {

                            Text(form.formTitle)
                                .font(.largeTitle)
                                .foregroundColor(textColor)

                            ForEach(
                                form.fields.sorted {
                                    $0.order < $1.order
                                }
                            ) { field in

                                DynamicFieldView(
                                    field: field,
                                    viewModel: viewModel,
                                    focusedField: $focusedField
                                )
                            }

                            Button("Save") {

                                UIApplication.shared.hideKeyboard()

                                if viewModel.validate() {

                                    print(viewModel.submissionPayload())
                                    showSuccess = true

                                } else {

                                    print("Validation Failed")
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        .safeAreaPadding(.top)
                    }
                }
                .alert("Success", isPresented: $showSuccess) {

                    Button("OK") { }

                } message: {

                    Text("Form submitted successfully")
                }
            }  else {

                ProgressView()
            }
        }
    }
}
