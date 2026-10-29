# Spin the Wheel 🎡

A Flutter and Dart project exploring mobile application development through individual experiments and a final interactive Spin the Wheel application.

## Project Overview

Spin the Wheel is a decision-making application that allows users to manage a list of choices and randomly select an option. The project explores Flutter widgets, responsive layouts, navigation, state management, themes, form validation, animation, REST API integration, and unit testing.

## Technologies Used

- Flutter
- Dart
- Provider for state management
- HTTP package for API requests
- JSONPlaceholder for sample API data
- Flutter Test
- Android Studio and Chrome

## Project Screenshots and Implementation

### Navigation and Wheel Options

Implemented navigation between screens and displayed available food options such as Pizza, Burger, Biryani, and Noodles.

<img width="2047" height="1390" alt="image" src="https://github.com/user-attachments/assets/1639ae22-e635-4915-95c5-36ebff0bf6f8" />




<img width="2048" height="1381" alt="image" src="https://github.com/user-attachments/assets/1b7198b9-f723-40fd-b331-d22d31800818" />


### State Management

Demonstrated `setState` using a counter and Provider using selectable food options.

<img width="2048" height="1359" alt="image" src="https://github.com/user-attachments/assets/49584305-f365-463c-88d8-efbb4d3c511c" />


### Themes and Reusable Widgets

Explored reusable list items, icons, and consistent theme styling in Flutter.

<img width="2048" height="1372" alt="image" src="https://github.com/user-attachments/assets/1d01e07c-8e6b-4882-9a28-9d30a23d98a7" />


### Form Validation and Option Management

Implemented a text field and an Add Option button to enter food choices and display them in a list.

<img width="2048" height="1369" alt="image" src="https://github.com/user-attachments/assets/579704a1-d002-41ca-a606-a9bf9e7302f9" />


### Wheel Animation

Used Flutter animation concepts to demonstrate a rotating wheel graphic with an ease-out curve.

<img width="2048" height="1357" alt="image" src="https://github.com/user-attachments/assets/f0e25351-4d17-4a40-ac2c-d4393e2e24dc" />


### Automated Testing

Implemented a random-selection utility and tests for valid and empty option lists.

<img width="1878" height="642" alt="image" src="https://github.com/user-attachments/assets/f9d45483-1a8a-468a-90a6-17092997a6ea" />


### Final Application

Integrated the wheel interface, choice selection, and option management into the final application.

<img width="2048" height="1369" alt="image" src="https://github.com/user-attachments/assets/b2bc1228-a817-4bd0-8013-f2b68537f8fc" />




<img width="2048" height="1377" alt="image" src="https://github.com/user-attachments/assets/a2cf74e2-a5cf-4fa8-bfb8-a200a5d85081" />


## How to Run the Project

Clone the repository:

```bash
git clone https://github.com/priyanka-249/spin-the-wheel.git
cd spin-the-wheel
```

Install dependencies:

```bash
flutter pub get
```

Run the application in Chrome:

```bash
flutter run -d chrome
```

Run the focused Experiment 10 tests:

```bash
flutter test test/experiment_10_test.dart
```

## Learning Outcomes

- Practised Dart fundamentals and random selection.
- Learned Flutter widget composition and responsive layouts.
- Implemented navigation and state management.
- Created reusable widgets and applied themes.
- Added form validation and option management.
- Explored animations and REST API integration.
- Wrote and executed unit tests for random-selection logic.

## Future Improvements

- Synchronize the selected result with the wheel's final position.
- Add persistent storage for user-defined options.
- Expand automated test coverage.
- Improve accessibility and customization.

## Repository

[View the project on GitHub](https://github.com/priyanka-249/spin-the-wheel)
