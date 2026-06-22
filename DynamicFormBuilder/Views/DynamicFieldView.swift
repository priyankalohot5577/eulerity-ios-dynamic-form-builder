import SwiftUI

struct DynamicFieldView: View {

    let field: Field

    @ObservedObject var viewModel: FormViewModel
    var focusedField: FocusState<String?>.Binding

    var body: some View {

        switch field.type {

        case .text:

            TextFieldComponent(
                    field: field,
                    viewModel: viewModel,
                    focusedField: focusedField
                )


        case .dropdown:
            DropdownComponent(
                field: field,
                viewModel: viewModel
            )

        case .checkbox:

            CheckboxComponent(
                    field: field,
                    viewModel: viewModel
                )

        case .toggle:

            ToggleComponent(
                    field: field,
                    viewModel: viewModel
                )
        case .colorPicker:
            ColorPickerComponent(
                field: field,
                viewModel: viewModel
            )
        case nil:

            EmptyView()
        }
    }
}
