
:

🎉 Animated Login Screen with Rive in Flutter

This project is a Flutter login screen featuring an interactive Rive character 🐻 that reacts to user input, providing a fun and engaging experience for users.

🌟 Features

👀 Eye Tracking – Eyes follow the typing in the email field.

🙈 Hands Up – Character covers eyes when typing the password.

😀😢 Happy or Sad Reactions – Character reacts instantly based on login success or failure.

⏱️ Debounced Input – Eyes return to neutral 1 second after typing stops.

🔒 Password Toggle & Focus – Show/hide password with automatic focus on email field.

👆 Tap Anywhere – Reset character pose by tapping outside input fields.

🗂 Project Structure
lib/
├── main.dart             # Entry point
├── login_screen.dart     # Login screen with Rive integration
├── rive_animation.riv    # Rive animation asset


main.dart initializes the app.

login_screen.dart contains the UI, text fields, buttons, and Rive character logic.

rive_animation.riv is the animation file used for the interactive character.

🎨 About Rive

Rive
 is a real-time interactive animation tool.

State Machine: Controls animations based on user interactions (e.g., triggers, booleans, numbers).

This project uses a state machine called "Login Machine" to handle eye tracking, hands up, and success/fail reactions.

📷 Demo

![Demo de la app](/osito.gif)

🏫 Course Information

Course: Mobile Application Development

Instructor: Rodrigo Fidel Gaxiola Sosa

🔗 Credits

Animation created by Original Rive Creator: https://rive.app/marketplace/3645-7621-remix-of-login-machine/
.

This README is designed to be attractive with emojis while explaining functionality, project structure, and Rive integration in English.