# Quotations App

A Flutter application implementing a quotation management system with a focus on clean architecture and modern development practices.

## Features

- Create, read, update, and delete quotations
- Local storage using Hive database
- BLoC pattern for state management


## Architecture

The application is built using Clean Architecture with the following layers:

- **Domain Layer**: Contains business logic and entities
- **Data Layer**: Implements repositories and handles data sources
- **Presentation Layer**: Handles UI and state management

### Core Module
The core module contains application-wide functionality:
- `error/`: Error handling and exceptions
  - `exceptions.dart`: Custom exception definitions
  - `failures.dart`: Failure cases for error handling
- `routing/`: Navigation and routing
  - `app_router.dart`: Application routing configuration
- `utils/`: Shared utilities
  - `constants.dart`: Application constants and configurations
  - `formatters.dart`: Data formatting utilities
  - `validators.dart`: Form validation logic



## Screenshots
Images showcasing the app's interface and functionality can be found in the `showcase_images` folder. 

