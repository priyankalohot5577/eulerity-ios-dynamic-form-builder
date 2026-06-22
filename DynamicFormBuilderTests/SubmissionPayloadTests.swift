import XCTest
@testable import DynamicFormBuilder

@MainActor
final class SubmissionPayloadTests: XCTestCase {

    func testSubmissionPayloadContainsValues() {

        let viewModel = FormViewModel()

        viewModel.updateText(
            "Campaign A",
            for: "campaign_name"
        )

        let payload =
            viewModel.submissionPayload()

        XCTAssertEqual(
            payload["campaign_name"] as? String,
            "Campaign A"
        )
    }
}
