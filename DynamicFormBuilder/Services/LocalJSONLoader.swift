import Foundation

final class LocalJSONLoader {

    static func loadForm() throws -> FormResponse {

        guard let url = Bundle.main.url(
            forResource: "form",
            withExtension: "json"
        ) else {
            throw NSError(
                domain: "JSON",
                code: 404
            )
        }

        let data = try Data(contentsOf: url)

        return try JSONDecoder()
            .decode(FormResponse.self, from: data)
    }
}
