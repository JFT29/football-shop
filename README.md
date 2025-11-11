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

------------------------------------------

## Answering the Questions for Assignment 8

### Q1. Explain the difference between `Navigator.push()` and `Navigator.pushReplacement()` in Flutter. In what context of your application is each best used?

`Navigator.push()` adds a new page on top of the navigation stack, allowing the user to go back to the previous page using the back button. It’s used when the previous page should still be accessible, such as when moving from the main menu to the product form page. In my app, I use `Navigator.push()` when opening the **Create Product Form**, so the user can return to the home menu afterward.

`Navigator.pushReplacement()`, on the other hand, replaces the current page in the stack entirely. The previous page is removed, meaning the user can’t navigate back to it. This is more suitable for transitions where returning doesn’t make sense, such as moving from a login page to a main dashboard after authentication.

In summary:
- `Navigator.push()` → adds a new page, keeps the previous one (used for normal navigation).
- `Navigator.pushReplacement()` → replaces the current page, removing the previous one (used for permanent transitions).


### Q2. How do you use hierarchy widgets like `Scaffold`, `AppBar`, and `Drawer` to build a consistent page structure in your application?

`Scaffold`, `AppBar`, and `Drawer` provide a clean, consistent structure across all screens.  
- **Scaffold** is the base layout for each page, giving a standard structure that holds an app bar, body, and drawer.  
- **AppBar** defines the title and navigation bar at the top, maintaining visual consistency and quick navigation access.  
- **Drawer** acts as a sidebar menu, letting users navigate between pages like *Home*, *Create Product*, or *About Page* without rebuilding the layout manually.

In this app, every major page (menu and product form) uses the same `Scaffold` structure with a matching `AppBar` and the same `LeftDrawer` widget. This ensures that navigation and branding stay consistent no matter which page the user visits.

### Q3. In the context of user interface design, what do you think are the advantages of using layout widgets like `Padding`, `SingleChildScrollView`, and `ListView` when displaying form elements? Provide usage examples from your application.

Layout widgets make the UI readable, responsive, and user-friendly.  
- **Padding** adds breathing space between form fields, preventing the UI from looking cluttered.  
- **SingleChildScrollView** allows the form to scroll vertically if it’s too long for the screen, which prevents overflow errors and keeps it accessible on smaller devices.  
- **ListView** or column-like layouts make it easy to stack widgets vertically in an organized way.

For example, in my `ProductFormPage`, the form fields for *name*, *price*, *thumbnail*, *category*, and *description* are wrapped in a `SingleChildScrollView` with consistent `Padding` for each field. This makes the form easy to read and scroll through even on small screens, ensuring a smooth and pleasant user experience.

### Q4. How do you set the color theme so that your Football Shop has a visual identity that is consistent with the shop brand?

The color theme is defined in `main.dart` inside the `MaterialApp` widget using a `ThemeData` configuration. I use a **blue primary color** and **indigo accents**, matching the Football Shop’s branding style inspired by professional sports shops.

Example:
```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(secondary: Colors.indigoAccent),
  useMaterial3: true,
),