import XCTest
@testable import DynamicFormBuilder

@MainActor
final class ValidationTests: XCTestCase {

    func testRequiredTextFieldValidationFails() {

        let viewModel = FormViewModel()

        let result = viewModel.validate()

        XCTAssertFalse(result)

        XCTAssertNotNil(
            viewModel.validationErrors["campaign_name"]
        )
    }
}
