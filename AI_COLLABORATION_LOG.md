# AI Collaboration Log

## Tool Used

* ChatGPT (OpenAI)

---

## Objective

Used AI as a collaborative development assistant during the implementation of the Dynamic Form Builder take-home exercise.

AI was primarily used for:

* Architecture discussions
* Edge-case analysis
* Testing suggestions
* Validation review
* Git/GitHub workflow assistance
* README preparation

All suggestions were reviewed, understood, and modified as needed before being incorporated into the final solution.

---

## Interaction 1 – Project Architecture

### Prompt

How should I structure a dynamic form builder in SwiftUI using MVVM and Server-Driven UI principles?

### Outcome

AI suggested:

* MVVM architecture
* Separate Models, Views, ViewModels, Services, and Utilities
* Dynamic rendering based on field type

### Decision

Accepted.

This aligned with the requirements and resulted in the final project structure.

---

## Interaction 2 – Polymorphic JSON Parsing

### Prompt

How should I decode fields where the UI component depends on a "type" field and some components require additional subtype information?

### Outcome

AI suggested:

* Using Codable models
* Mapping JSON values into enums
* Creating a computed component type from raw JSON values

### Decision

Accepted with modifications to fit the project structure.

---

## Interaction 3 – Validation Logic

### Prompt

How should required validation work for dynamically generated form fields?

### Outcome

AI suggested validating:

* Text fields
* Dropdowns
* Toggles
* Checkboxes

and storing errors in a centralized dictionary.

### Decision

Accepted.

Implemented validation inside `FormViewModel`.

---

## Interaction 4 – Edge Case Handling

### Prompt

How should a required dropdown behave when the payload contains an empty options array?

### Outcome

AI highlighted that the user cannot satisfy a required field with no available options.

### Decision

Implemented defensive behavior:

* Empty dropdowns are displayed as unavailable.
* Validation is skipped for dropdowns with no options.

Reason:
The backend configuration is invalid and the user should not be blocked from submission.

---

## Interaction 5 – Unit Testing

### Prompt

What unit tests would provide the best coverage for this assignment?

### Outcome

AI suggested tests for:

* JSON decoding
* Validation
* Submission payload generation
* Unknown component handling

### Decision

Implemented tests focused on decoding and validation behavior.

---

## Interaction 6 – GitHub Repository Setup

### Prompt

How should I structure and prepare the repository for submission?

### Outcome

AI assisted with:

* Creating a public repository
* Organizing documentation
* Adding README and collaboration log files
* Verifying Git status before submission

### Decision

Accepted.

---

## Interaction 7 – Documentation

### Prompt

Help create a README that satisfies the assignment requirements.

### Outcome

AI generated a README template covering:

* Architecture
* Product decisions
* Improvements
* Running instructions

### Decision

Reviewed and adapted for the final submission.

---

## What AI Got Wrong

One discussion suggested additional implementation complexity around optional component handling that was unnecessary for the scope of the assignment.

The suggestion was not adopted.

---

## Final Notes

AI was used as a collaborative development assistant throughout the exercise.

All code, architectural decisions, debugging, testing, and final implementation details were reviewed and understood before inclusion in the project.
