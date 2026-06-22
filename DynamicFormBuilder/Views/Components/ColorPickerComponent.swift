import SwiftUI

struct ColorPickerComponent: View {

    let field: Field

    @ObservedObject var viewModel: FormViewModel

    private var textColor: Color {

        Color(
            hex:
                viewModel.form?
                    .theme.textColor
                ?? "#E0E0E0"
        ) ?? .white
    }

    private var borderColor: Color {

        Color(
            hex:
                viewModel.form?
                    .theme.borderColor
                ?? "#333333"
        ) ?? .gray
    }

    private var errorColor: Color {

        Color(
            hex:
                viewModel.form?
                    .theme.errorColor
                ?? "#CF6679"
        ) ?? .red
    }

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(field.label ?? "")
                .foregroundColor(textColor)

            ColorPicker(
                "Select Color",
                selection: colorBinding
            )
            .foregroundColor(textColor)
            .padding()
            .overlay(
                RoundedRectangle(
                    cornerRadius: 8
                )
                .stroke(
                    borderColor,
                    lineWidth: 1
                )
            )

            if let error =
                viewModel.validationErrors[field.id] {

                Text(error)
                    .font(.caption)
                    .foregroundColor(errorColor)
            }
        }
    }

    private var colorBinding: Binding<Color> {

        Binding(
            get: {

                let hex = viewModel.textValue(
                    for: field.id
                )

                return Color(hex: hex) ?? .blue
            },
            set: { newColor in

                viewModel.updateText(
                    colorToHex(newColor),
                    for: field.id
                )
            }
        )
    }

    private func colorToHex(
        _ color: Color
    ) -> String {

        guard let components =
            UIColor(color).cgColor.components
        else {
            return "#0000FF"
        }

        let r =
            Int(components[0] * 255)

        let g =
            Int(components.count > 2
                ? components[1] * 255
                : components[0] * 255)

        let b =
            Int(components.count > 2
                ? components[2] * 255
                : components[0] * 255)

        return String(
            format: "#%02X%02X%02X",
            r, g, b
        )
    }
}
