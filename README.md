## The Gutendex Apps

This project demonstrates the implementation of a Flutter application that interacts with the Gutendex book REST API. The application is designed to provide users with the following features:

* Book Display and Search: Users can browse and search for books available in the Gutendex database.
* Favorites: Users have the ability to save books they like to a favorites list for easy access.
* Book Details: Users can retrieve and view detailed information about each book.


## Technical Details

This project demonstrates the implementation of a Flutter application that interacts with the Gutendex book REST API. The application is designed with a robust and clean architecture, leveraging dependency injection to decouple classes and enhance maintainability. It also includes a sophisticated error handling mechanism to gracefully capture and display error messages from the REST API.

- Flavoring : The project supports multiple build configurations for different environments (e.g., development, staging, production).
- Decoupled : The application is structured into distinct layers (UI, BLoC, Data Source), ensuring separation of concerns and ease of development.
- Dependency Injection: Utilizes dependency injection to manage dependencies efficiently, promoting modularity and testability.
- Reusable Components: The design includes reusable components, facilitating code reuse and reducing redundancy.
- Sentry error tracking integration

## How To Run?

- `flutter pub get`
- `flutter run -t lib/main_prod.dart`
- enjoy

## Notes

- The api error is so indempotent, like somehow its throw 404
- To avoid double execution api call when user scroll down, i introduce `throttling`