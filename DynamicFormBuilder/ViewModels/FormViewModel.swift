import Foundation
import Combine

@MainActor
final class FormViewModel: ObservableObject {
    
    @Published var hasAttemptedSubmit = false
    
    @Published var form: FormResponse?
    
    @Published var values: [String: FieldValue] = [:]
    
    @Published var validationErrors: [String: String] = [:]
    
    init() {
        loadForm()
    }
    
    private func loadForm() {
        
        do {
            
            form = try LocalJSONLoader.loadForm()
            initializeDefaults()
        } catch {
            
            print(error)
        }
    }
    func submissionPayload() -> [String: Any] {
        var payload: [String: Any] = [:]

        for (key, value) in values {

            switch value {

            case .text(let text):
                payload[key] = text

            case .bool(let bool):
                payload[key] = bool

            case .singleSelection(let value):
                payload[key] = value

            case .multiSelection(let values):
                payload[key] = Array(values)
            }
        }

        return payload
    }
    private func initializeDefaults() {
        
        guard let form else { return }
        
        for field in form.fields {
            
            switch field.type {
                
            case .text:
                
                if case let .string(value)? = field.defaultValue {

                    let finalValue: String

                    if let maxLength = field.maxLength {
                        finalValue = String(value.prefix(maxLength))
                    } else {
                        finalValue = value
                    }

                    values[field.id] = .text(finalValue)
                }
                
            case .toggle, .checkbox:
                
                if case let .bool(value)? = field.defaultValue {
                    
                    values[field.id] = .bool(value)
                }
                
                
            case .dropdown:
                
                if field.allowMultiple == true {
                    
                    values[field.id] = .multiSelection(
                        Set(field.defaultValues ?? [])
                    )
                    
                } else if let first = field.defaultValues?.first {
                    
                    values[field.id] = .singleSelection(first)
                }
                
                
            default:
                break
            }
        }
    }
    func textValue(for fieldId: String) -> String {
        
        guard let value = values[fieldId] else {
            return ""
        }
        
        if case let .text(text) = value {
            return text
        }
        
        return ""
    }
    
    func updateText(
        _ value: String,
        for fieldId: String
    ) {
        print("Updating field:", fieldId)

        values[fieldId] = .text(value)

        validationErrors.removeValue(
            forKey: fieldId
        )

        print("Current errors:", validationErrors)
    }
    
    func singleSelectionValue(
        for fieldId: String
    ) -> String {
        
        guard let value = values[fieldId] else {
            return ""
        }
        
        if case let .singleSelection(id) = value {
            return id
        }
        
        return ""
    }
    
    func multiSelectionValue(
        for fieldId: String
    ) -> Set<String> {
        
        guard let value = values[fieldId] else {
            return []
        }
        
        if case let .multiSelection(ids) = value {
            return ids
        }
        
        return []
    }
    func updateSingleSelection(
        _ value: String,
        for fieldId: String
    ) {
        values[fieldId] = .singleSelection(value)
        validationErrors.removeValue(forKey: fieldId)
    }


    func updateMultiSelection(
        _ value: Set<String>,
        for fieldId: String
    ) {
        values[fieldId] = .multiSelection(value)
        validationErrors.removeValue(forKey: fieldId)
    }
    func boolValue(
        for fieldId: String
    ) -> Bool {

        guard let value = values[fieldId] else {
            return false
        }

        if case let .bool(boolValue) = value {
            return boolValue
        }

        return false
    }
    func updateBool(
        _ value: Bool,
        for fieldId: String
    ) {
        values[fieldId] = .bool(value)

        guard hasAttemptedSubmit else {
            return
        }

        if value {

            validationErrors.removeValue(
                forKey: fieldId
            )

        } else {

            validationErrors[fieldId] = "Required"
        }
    }
    func validate() -> Bool {
        hasAttemptedSubmit = true
        validationErrors.removeAll()

        guard let form else {
            return false
        }

        var isValid = true

        for field in form.fields {

            guard field.required == true else {
                continue
            }

            switch field.type {

            case .text:

                let value = textValue(
                    for: field.id
                )

                if value.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ).isEmpty {
                    print("Adding error for:", field.id)
                    validationErrors[field.id] =
                        field.errorMessage
                        ?? "Required"

                    isValid = false
                }

            case .checkbox:

                if !boolValue(for: field.id) {
                    print("Adding error for:", field.id)
                    validationErrors[field.id] =
                        field.errorMessage
                        ?? "Required"

                    isValid = false
                }

            case .dropdown:
                if (field.options ?? []).isEmpty {
                    continue
                }
                
                if field.allowMultiple == true {

                    let values =
                        multiSelectionValue(
                            for: field.id
                        )

                    if values.isEmpty {
                        print("Adding error for:", field.id)
                        validationErrors[field.id] =
                        field.errorMessage ?? "Required"

                        isValid = false
                    }

                } else {

                    let value =
                        singleSelectionValue(
                            for: field.id
                        )

                    if value.isEmpty {

                        print("Adding error for:", field.id)
                        validationErrors[field.id] =
                        field.errorMessage ?? "Required"

                        isValid = false
                    }
                }
            case .toggle:

                if !boolValue(for: field.id) {
                    print("Adding error for:", field.id)
                    validationErrors[field.id] =
                        field.errorMessage ?? "Required"

                    isValid = false
                }
            case .colorPicker:

                let value = textValue(for: field.id)

                if value.isEmpty {

                    validationErrors[field.id] =
                        field.errorMessage ?? "Required"

                    isValid = false
                }
            default:
                break
            }
        }

        return isValid
    }
}
