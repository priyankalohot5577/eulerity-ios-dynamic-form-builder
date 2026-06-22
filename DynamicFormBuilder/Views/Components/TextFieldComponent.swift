import SwiftUI

struct TextFieldComponent: View {

    let field: Field

    @ObservedObject var viewModel: FormViewModel
    var focusedField: FocusState<String?>.Binding

    private var textColor: Color {
        Color(
            hex: viewModel.form?.theme.textColor
            ?? "#000000"
        ) ?? .black
    }

    private var borderColor: Color {
        Color(
            hex: viewModel.form?.theme.borderColor
            ?? "#D1D5DB"
        ) ?? .gray
    }

    private var errorColor: Color {
        Color(
            hex: viewModel.form?.theme.errorColor
            ?? "#B91C1C"
        ) ?? .red
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(field.label ?? "")
                .foregroundColor(textColor)

            fieldView

            if let maxLength = field.maxLength {

                HStack {

                    Spacer()

                    Text(
                        "\(binding.wrappedValue.count)/\(maxLength)"
                    )
                    .font(.caption)
                    .foregroundColor(textColor)
                }
            }

            if let error =
                viewModel.validationErrors[field.id] {

                Text(error)
                    .font(.caption)
                    .foregroundColor(errorColor)
            }
        }
    }

    private var binding: Binding<String> {

        Binding(
            get: {
                viewModel.textValue(
                    for: field.id
                )
            },
            set: { newValue in

                var value = newValue

                if let maxLength =
                    field.maxLength {

                    value = String(
                        value.prefix(maxLength)
                    )
                }

                viewModel.updateText(
                    value,
                    for: field.id
                )
            }
        )
    }

    @ViewBuilder
    private var fieldView: some View {

        switch field.subtype {

        case .plain, nil:

            TextField(
                field.placeholder ?? "",
                text: binding
            )
            .padding(12)
            .foregroundColor(textColor)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 8
                )
                .stroke(
                    borderColor,
                    lineWidth: 1
                )
            )
            .focused(
                focusedField,
                equals: field.id
            )

        case .number:

            TextField(
                field.placeholder ?? "",
                text: Binding(
                    get: {
                        binding.wrappedValue
                    },
                    set: { newValue in

                        let filtered =
                            newValue.filter {
                                "0123456789."
                                    .contains($0)
                            }

                        binding.wrappedValue =
                            filtered
                    }
                )
            )
            .keyboardType(.decimalPad)
            .padding(12)
            .foregroundColor(textColor)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 8
                )
                .stroke(
                    borderColor,
                    lineWidth: 1
                )
            )
            .focused(
                focusedField,
                equals: field.id
            )

        case .uri:

            TextField(
                field.placeholder ?? "",
                text: binding
            )
            .keyboardType(.URL)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(12)
            .foregroundColor(textColor)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 8
                )
                .stroke(
                    borderColor,
                    lineWidth: 1
                )
            )
            .focused(
                focusedField,
                equals: field.id
            )

        case .secure:

            SecureField(
                field.placeholder ?? "",
                text: binding
            )
            .padding(12)
            .foregroundColor(textColor)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 8
                )
                .stroke(
                    borderColor,
                    lineWidth: 1
                )
            )
            .focused(
                focusedField,
                equals: field.id
            )

        case .multiline:

            TextEditor(text: binding)
                .frame(minHeight: 120)
                .foregroundColor(textColor)
                .scrollContentBackground(.hidden)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 8
                    )
                    .stroke(
                        borderColor,
                        lineWidth: 1
                    )
                )
                .focused(
                    focusedField,
                    equals: field.id
                )
        }
    }
}
