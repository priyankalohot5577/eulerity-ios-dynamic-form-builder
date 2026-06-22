import SwiftUI

struct DropdownComponent: View {

    let field: Field

    @ObservedObject var viewModel: FormViewModel

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

        VStack(alignment: .leading, spacing: 4) {

            if field.allowMultiple == true {

                multiSelectView

            } else {

                singleSelectView
            }

            if let error = viewModel.validationErrors[field.id] {

                Text(error)
                    .font(.caption)
                    .foregroundColor(errorColor)
            }
        }
    }

    private var singleSelectView: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(field.label ?? "")
                .foregroundColor(textColor)

            if (field.options ?? []).isEmpty {

                Text("No options available")
                    .foregroundColor(.gray)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                borderColor,
                                lineWidth: 1
                            )
                    )

            } else {

                Picker(
                    field.label ?? "",
                    selection: singleSelectionBinding
                ) {

                    ForEach(field.options ?? []) { option in

                        Text(option.label)
                            .tag(option.id)
                    }
                }
                .pickerStyle(.menu)
                .tint(textColor)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            borderColor,
                            lineWidth: 1
                        )
                )
            }
        }
    }

    private var multiSelectView: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(field.label ?? "")
                .foregroundColor(textColor)

            VStack(alignment: .leading, spacing: 8) {

                ForEach(field.options ?? []) { option in

                    Button {

                        toggle(option.id)

                    } label: {

                        HStack {

                            Image(
                                systemName:
                                    selectedIds.contains(option.id)
                                    ? "checkmark.square.fill"
                                    : "square"
                            )
                            .foregroundColor(textColor)

                            Text(option.label)
                                .foregroundColor(textColor)

                            Spacer()
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        borderColor,
                        lineWidth: 1
                    )
            )
        }
    }

    private var selectedIds: Set<String> {

        viewModel.multiSelectionValue(
            for: field.id
        )
    }

    private var singleSelectionBinding: Binding<String> {

        Binding(
            get: {
                viewModel.singleSelectionValue(
                    for: field.id
                )
            },
            set: { newValue in

                viewModel.updateSingleSelection(
                    newValue,
                    for: field.id
                )
            }
        )
    }

    private func toggle(
        _ optionId: String
    ) {

        var ids = selectedIds

        if ids.contains(optionId) {

            ids.remove(optionId)

        } else {

            ids.insert(optionId)
        }

        viewModel.updateMultiSelection(
            ids,
            for: field.id
        )
    }
}
