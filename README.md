# Eulerity iOS Dynamic Form Builder

## Overview

This project is a SwiftUI-based Server-Driven UI (SDUI) form renderer built as part of the Eulerity iOS Developer Take-Home Exercise.

The application dynamically generates an entire form from a local JSON payload bundled with the application. All UI components, validation rules, ordering, and theming are driven by JSON configuration rather than hardcoded views.

The app supports dynamic field rendering, validation, theming, state management, and submission payload generation while remaining resilient to unsupported or malformed field definitions.

---

## Technical Stack

* Swift 5
* SwiftUI
* MVVM Architecture
* Codable for JSON Parsing
* iOS 16.0+

---

## Architecture

The project follows the MVVM (Model-View-ViewModel) pattern.

### Models

Models represent the JSON structure and are responsible for decoding form data.

Key models include:

* FormResponse
* Field
* Theme
* Option
* DefaultValue
* FieldValue

### ViewModel

`FormViewModel` is responsible for:

* Loading and decoding local JSON
* Initializing default values
* Managing dynamic field state
* Handling validation
* Tracking validation errors
* Building the final submission payload

### Views

The UI layer consists of:

* ContentView
* DynamicFieldView
* Reusable field components

Each component is rendered dynamically based on the field type and subtype received from the JSON payload.

---

## Supported Components

### TEXT

Supported subtypes:

* PLAIN
* MULTILINE
* NUMBER
* URI
* SECURE

Features:

* Placeholder support
* Character limit support
* Required validation
* Dynamic keyboard configuration

### DROPDOWN

Features:

* Single Select
* Multi Select
* Default Values
* ID-based state storage

### TOGGLE

Features:

* Boolean state management
* Required validation support

### CHECKBOX

Features:

* Boolean state management
* Required validation support

---

## Dynamic Rendering

Fields are rendered dynamically and sorted using the `order` property provided by the JSON payload.

The application does not rely on the array order from the payload and instead uses the backend-controlled ordering mechanism.

---

## State Management

Dynamic field values are stored within the ViewModel using a centralized state dictionary:

* Text values
* Boolean values
* Single selections
* Multi selections

The final submission payload is generated from this state and converted into key-value pairs suitable for backend submission.

Example:

```json
{
  "campaign_name": "Summer Sale",
  "ad_networks": ["net_meta"],
  "daily_budget": "100",
  "accept_legal": true
}
```

---

## Theming

The UI theme is fully driven by the JSON payload.

Supported theme properties:

* Background Color
* Text Color
* Border Color
* Error Color

Hex color values are converted into SwiftUI `Color` objects using a custom extension.

---

## Validation

Validation is triggered when the user taps the Save button.

Supported validation rules:

* Required text fields
* Required dropdown selections
* Required checkboxes
* Required toggles

Validation errors are stored in the ViewModel and displayed to the user.

If validation succeeds, the application generates a submission payload and displays a success confirmation.

---

## Defensive Parsing & Resilience

The application is designed to handle unexpected payload variations gracefully.

Handled scenarios include:

* Missing optional fields
* Missing placeholders
* Missing max length values
* Missing default values
* Empty dropdown option arrays
* Invalid theme color values
* Unsupported component types

Unknown component types are ignored rather than causing application crashes.

This allows the UI renderer to remain resilient when backend payloads evolve.

---

## Product Decisions

### 1. Validation Occurs on Save

Validation is performed when the user taps Save rather than while typing.

**Reason:**
This reduces unnecessary error noise and provides a cleaner user experience.

---

### 2. Unsupported Field Types Are Ignored

If the JSON payload contains an unsupported field type, the application safely skips rendering that component.

**Reason:**
Server-driven UI systems should remain functional when backend teams introduce new component types.

---

### 3. Default Values Respect Maximum Length Constraints

When a default text value exceeds the configured maximum length, it is automatically truncated.

**Reason:**
Prevents invalid initial state from appearing in the UI.

---

## Testing

Unit tests are included for:

* JSON parsing
* Validation logic
* Submission payload generation
* Field ordering

The tests help verify that the dynamic form engine behaves correctly and remains resilient to payload changes.

---

## What I Would Improve With More Time

* Clickable rich text links inside checkbox labels
* Regex-based validation support
* Dynamic keyboard navigation using FocusState
* Accessibility improvements
* Snapshot testing
* Additional unit test coverage
* Support for future component types such as Date Picker

---

## AI Collaboration

AI tools were used during development to:

* Discuss architecture approaches
* Review edge cases
* Explore validation strategies
* Generate testing ideas
* Review implementation decisions

All AI-generated suggestions were reviewed, validated, and adapted before inclusion in the final solution.

A detailed record of AI usage is available in:

`AI_COLLABORATION_LOG.md`

---

## Running the Project

1. Open the project in Xcode.
2. Select an iOS 16.0+ simulator.
3. Build and run the application.
4. The form loads from the bundled JSON file.
5. Fill in the required fields and tap Save.
6. The generated payload is printed to the console upon successful validation.

---

## Demo Video

Demo Video Link:
https://drive.google.com/file/d/11UfMB3N3KjGT16G8GMegaDGTCqvMq69O/view?usp=sharing
