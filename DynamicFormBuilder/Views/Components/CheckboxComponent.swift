import SwiftUI

struct CheckboxComponent: View {

    let field: Field

    @ObservedObject var viewModel: FormViewModel

    @Environment(\.openURL)
    private var openURL

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

    private var clickableTextColor: Color {
        Color(
            hex:
                field.clickableTextColor
                ?? "#2563EB"
        ) ?? .blue
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 4) {

            HStack(alignment: .top, spacing: 8) {

                Button {
                    viewModel.updateBool(
                        !isChecked,
                        for: field.id
                    )
                } label: {

                    Image(
                        systemName:
                            isChecked
                            ? "checkmark.square.fill"
                            : "square"
                    )
                    .foregroundColor(textColor)
                    .font(.title3)
                }
                .buttonStyle(.plain)

                Text(attributedLabel)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )

                Spacer(minLength: 0)
            }
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
            .contentShape(Rectangle())
            .onTapGesture {

                viewModel.updateBool(
                    !isChecked,
                    for: field.id
                )
            }

            if let error =
                viewModel.validationErrors[field.id] {

                Text(error)
                    .font(.caption)
                    .foregroundColor(errorColor)
            }
        }
    }

    private var attributedLabel: AttributedString {

        var attributed =
            AttributedString(
                field.label ?? ""
            )

        attributed.foregroundColor =
            textColor

        guard let metadata =
            field.metadata else {

            return attributed
        }

        for (text, urlString)
            in metadata {

            guard
                let range =
                    attributed.range(
                        of: text
                    ),
                let url =
                    URL(string: urlString)
            else {
                continue
            }

            attributed[range]
                .foregroundColor =
                clickableTextColor

            attributed[range]
                .underlineStyle =
                .single

            attributed[range]
                .link = url
        }

        return attributed
    }

    private var isChecked: Bool {

        viewModel.boolValue(
            for: field.id
        )
    }
}
