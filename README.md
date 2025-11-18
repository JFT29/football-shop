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
```
------------------------------------------

## Answering the Questions for Assignment 9

### Q1. Why do we need to create a Dart model when fetching/sending JSON data?

A **Dart model** gives structure and type safety to the JSON data we send or receive.  
Without it, the app would rely on `Map<String, dynamic>` everywhere, which causes:

- No type validation (any field can be the wrong type and crash later)
- Unreliable null safety (missing fields cause runtime errors)
- Low maintainability (you must remember map keys manually each time)

Using a model ensures **data consistency** and makes the code easier to maintain as the project grows.

---

### Q2. What is the purpose of the http and CookieRequest packages in this assignment?

- **http package** → general-purpose HTTP client. Handles simple GET/POST requests but does *not* manage cookies or authentication.
- **CookieRequest package** → automatically stores Django session cookies + CSRF tokens. Required so Flutter stays logged in across pages.

In short:  
**http = basic requests**  
**CookieRequest = authentication-aware client for Django**

---

### Q3. Why must the CookieRequest instance be shared across the whole Flutter app?

Authentication in Django relies on the **session cookie**.  
If each screen created its own CookieRequest:

- Every page would have a different session  
- Django would reject requests with “Unauthorized”  
- The user would appear “logged out” on every navigation  

Using **Provider** allows one shared CookieRequest instance so the user stays authenticated across all pages.

---

### Q4. Connectivity configuration required for Flutter ↔ Django communication

To make Flutter communicate smoothly with Django, we must configure:

- **10.0.2.2 in ALLOWED_HOSTS**  
  Android emulators route localhost through 10.0.2.2.

- **CORS configuration**  
  Required for Flutter Web to access Django APIs.

- **SameSite, CSRF, and cookie settings**  
  Django must allow session cookies to be sent across origins.

- **Internet permission in AndroidManifest.xml**  
  Without this, the emulator silently blocks network access.

If any of these are missing, Flutter cannot fetch data, log in, or interact with Django APIs.

---

### Q5. Describe the data transmission process from user input until the data is shown in Flutter

1. **User fills a form** on Flutter.  
2. Flutter **validates inputs locally**.  
3. Flutter sends data to Django using **`CookieRequest.post()`**.  
4. Django validates and saves it to the **database**.  
5. Django responds with **JSON**.  
6. Flutter parses the JSON into a **Dart model**.  
7. The **UI updates** and displays the result.

This ensures a complete end-to-end round-trip between frontend and backend.

---

### Q6. Explain how authentication works: login, registration, logout

**Login**  
Flutter sends username & password → Django checks → session created → CookieRequest saves cookies → Flutter navigates to the menu.

**Registration**  
Flutter sends form data → Django creates new user → logs them in → returns session cookie.

**Logout**  
Flutter calls `/api/auth/logout/` → Django clears session → CookieRequest resets.

If the cookie is missing or invalid, Django returns **401 Unauthorized**.

---

### Q7. How I implemented the assignment based on the checklist

- Tested Django deployment to ensure all API endpoints work.  
- Implemented registration & login using Flutter forms.  
- Integrated Django auth with Flutter via **CookieRequest + Provider**.  
- Created a **Dart model** mirroring Django’s Product model.  
- Built a product list page fetching data from `/api/products/`.  
- Added **filtering** so each user sees only their own products.  
- Created a product detail page with full attributes and a back button.  
- Built a complete **product creation form** connected to `/api/products/create/`.  
- Configured **CORS, cookies, ALLOWED_HOSTS**, and Android network permissions so Flutter Web & emulator can communicate reliably with Django.

---