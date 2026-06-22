import Foundation

struct Field: Codable, Identifiable {

    let id: String
    let order: Int
    let defaultValue: DefaultValue?
    let typeRaw: String?
    let subtype: TextSubtype?

    let label: String?
    let placeholder: String?

    let maxLength: Int?
    let required: Bool?

    let errorMessage: String?

    let allowMultiple: Bool?
    let defaultValues: [String]?
    let options: [Option]?

    let metadata: [String: String]?
    let clickableTextColor: String?

    var type: ComponentType? {
            typeRaw.flatMap(ComponentType.init(rawValue:))
        }

    enum CodingKeys: String, CodingKey {
        case id
        case order
        case typeRaw = "type"
        case subtype
        case defaultValue = "default_value"
        case label
        case placeholder

        case maxLength = "max_length"
        case required

        case errorMessage = "error_message"

        case allowMultiple = "allow_multiple"
        case defaultValues = "default_values"

        case options

        case metadata

        case clickableTextColor = "clickable_text_color"
    }
}


enum FieldValue {
    case text(String)
    case bool(Bool)
    case singleSelection(String)
    case multiSelection(Set<String>)
}

enum DefaultValue: Codable {

    case string(String)
    case bool(Bool)

    init(from decoder: Decoder) throws {

        let container =
            try decoder.singleValueContainer()

        if let value =
            try? container.decode(String.self) {

            self = .string(value)
            return
        }

        if let value =
            try? container.decode(Bool.self) {

            self = .bool(value)
            return
        }

        throw DecodingError.typeMismatch(
            DefaultValue.self,
            .init(
                codingPath: decoder.codingPath,
                debugDescription:
                    "Unsupported default value"
            )
        )
    }

    func encode(
        to encoder: Encoder
    ) throws {

        var container =
            encoder.singleValueContainer()

        switch self {

        case .string(let value):
            try container.encode(value)

        case .bool(let value):
            try container.encode(value)
        }
    }
}
