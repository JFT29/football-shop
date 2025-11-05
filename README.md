# football_shop
A simple Flutter application for my “Football Shop” concept.

## How to run
1. Ensure you have Flutter installed.  
2. At project root:  
   ```bash
   flutter pub get
   flutter run -d chrome  # or another target device

## Answering the Questions for Assignment 7

**Q1. What is a widget tree? How do parent–child relationships work?**

In Flutter, everything is a widget, and the UI is built in a structure called a widget tree. Each widget is either a parent or a child of another widget. Parents hold and organize children, while children inherit things like styling, layout constraints, and callbacks from their parents. When something changes in a widget, Flutter rebuilds only the affected part of the tree instead of redrawing everything. This makes UI updates fast and efficient.

**Q2. Widgets used in this project & their functions**

MaterialApp – acts as the root of the application, setting up theming, navigation, and Material Design structure.
Scaffold – provides the basic layout for the page, including the app bar and body, and supports SnackBars through ScaffoldMessenger.
AppBar – displays the top navigation bar containing the page title.
Center, Padding, Wrap – handle positioning and spacing: Center keeps the buttons in the middle, Padding adds consistent margins, and Wrap arranges buttons horizontally and wraps them if needed.
ElevatedButton.icon – the clickable buttons that combine icons and text.
Icon, Text – display the button icon and label.
SnackBar – short message that pops up at the bottom when a button is pressed.
ScaffoldMessenger.of(context).showSnackBar() – used to trigger and display the SnackBar messages.

**Q3. Function of MaterialApp & why used as root**

MaterialApp provides the main structure for the whole app. It sets up the title, theme, routes, and general visual style according to Material Design standards. It’s used as the root widget because most Flutter apps rely on Material components like buttons, app bars, and SnackBars that need access to this configuration.

**Q4. Difference: StatelessWidget vs StatefulWidget & when to choose**

A StatelessWidget is a widget that never changes once it’s built. It only depends on the data passed into it and doesn’t have any internal state. I’d use it for pages or components that stay the same every time they’re drawn, like static text or a title bar.

A StatefulWidget has an internal state that can change over time. It comes with a State object where the logic and variables live. Whenever the state changes, calling setState() rebuilds the widget to reflect the update. I’d use this for anything interactive or dynamic, like counters, forms, or data that changes while the app runs.

**Q5. What is BuildContext? Why important? How used in build?**

BuildContext tells a widget where it sits in the widget tree. It’s basically a reference that lets the widget look up information from its ancestors — like the current theme, size, or even other inherited widgets. In the build(BuildContext context) method, this context is used for things like calling Theme.of(context) to access colors or ScaffoldMessenger.of(context) to show a SnackBar. Without it, widgets wouldn’t know how to access the environment they belong to.

**Q6. “Hot reload” vs “Hot restart”**

Hot reload updates the code in the running app without resetting its state. It’s useful for quick UI tweaks because it keeps everything where it was — like form data, page position, or variables.

Hot restart completely restarts the app, clearing any saved state. It’s slower but necessary when the change affects app initialization or global variables. In short, hot reload keeps your progress, while hot restart starts from scratch.