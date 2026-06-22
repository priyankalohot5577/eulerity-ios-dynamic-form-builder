import XCTest
@testable import DynamicFormBuilder

final class FieldOrderingTests: XCTestCase {

    func testFieldsAreSortedByOrder() throws {

        let form =
            try LocalJSONLoader.loadForm()

        let sorted =
            form.fields.sorted {
                $0.order < $1.order
            }

        for index in 1..<sorted.count {

            XCTAssertTrue(
                sorted[index - 1].order
                <= sorted[index].order
            )
        }
    }
}
