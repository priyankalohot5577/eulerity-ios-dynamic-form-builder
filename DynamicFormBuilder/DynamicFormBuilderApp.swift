
import SwiftUI

@main
struct DynamicFormBuilderApp: App {

    init() {

        do {

            let form = try LocalJSONLoader.loadForm()
            form.fields.forEach {
                    print("id:", $0.id)
                    print("raw:", $0.typeRaw ?? "nil")
                    print("enum:", $0.type as Any)
                    print("-----")
                }

        } catch {

            print(error)
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
