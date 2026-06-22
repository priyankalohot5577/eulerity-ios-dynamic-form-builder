import XCTest
@testable import DynamicFormBuilder

@MainActor
final class FormLoadingTests: XCTestCase {

    func testFormLoadsSuccessfully() {

        let viewModel = FormViewModel()

        XCTAssertNotNil(viewModel.form)
        XCTAssertFalse(viewModel.form?.fields.isEmpty ?? true)
    }
}
