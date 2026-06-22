import XCTest
@testable import DynamicFormBuilder

@MainActor
final class SuccessfulValidationTests: XCTestCase {

    func testValidationPassesWhenRequiredFieldsAreFilled() {

        let viewModel = FormViewModel()

        viewModel.updateText(
            "Summer Sale",
            for: "campaign_name"
        )

        viewModel.updateText(
            "100",
            for: "daily_budget"
        )

        viewModel.updateBool(
            true,
            for: "accept_legal"
        )

        viewModel.updateMultiSelection(
            ["net_meta"],
            for: "ad_networks"
        )

        XCTAssertTrue(
            viewModel.validate()
        )
    }
}
