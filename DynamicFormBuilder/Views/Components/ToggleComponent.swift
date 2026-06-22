import SwiftUI

struct ToggleComponent: View {

    let field: Field

    @ObservedObject var viewModel: FormViewModel

    private var textColor: Color {
        Color(
            hex: viewModel.form?.theme.textColor ?? "#E0E0E0"
        ) ?? .white
    }

    private var borderColor: Color {
        Color(
            hex: viewModel.form?.theme.borderColor ?? "#D1D5DB"
        ) ?? .gray
    }

    private var errorColor: Color {
        Color(
            hex: viewModel.form?.theme.errorColor ?? "#CF6679"
        ) ?? .red
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 4) {

            Toggle(
                field.label ?? "",
                isOn: binding
            )
            .foregroundColor(textColor)
            .tint(borderColor)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )

            if let error = viewModel.validationErrors[field.id] {

                Text(error)
                    .font(.caption)
                    .foregroundColor(errorColor)
            }
        }
    }

    private var binding: Binding<Bool> {

        Binding(
            get: {
                viewModel.boolValue(
                    for: field.id
                )
            },
            set: { newValue in

                viewModel.updateBool(
                    newValue,
                    for: field.id
                )
            }
        )
    }
}
