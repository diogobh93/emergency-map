# Emergency Map

This project displays a map with a user's location pin. The real-time location can be obtained either through the device's GPS or by `obtaining approximate location via the internet.`

![screens1](https://github.com/diogobh93/emergency-map/assets/37723303/31de6318-aae6-4db8-86b4-714a7cb2e105)

**obs:** Errors that occur in the external layer are handled with a custom class called **`AppException`**, in which each mapped error has its own type and specific message. The customized error message is then handled in the controller for **`HomeStateError`**, making it possible to inform users about each type of error that occurred.

## App Features

- [x]  A screen to display the Google map.
- [x]  Custom error screen for all types of exceptions.
- [x]  Floating button to refresh the location.
- [x]  Support for multiple screen resolutions.
- [x]  Functionality with or without GPS being active.
- [x]  Online and offline functionality.

## Project Structure

The project is divided into the following folders:

- **`lib`**: Responsible for containing the project's source code.
  - **`app`**: Contains global application configurations such as themes, routes, and dependency injection.
  - **`core`**: Contains common services and functionalities for all other layers of the application.
    - **`constants`**: Contains static functionalities common to all layers.
    - **`environment`**: Contains the external API endpoint variable.
    - **`error`**: Contains custom exceptions for all layers.
    - **`settings`**: Contains specific configurations such as dependency injector, HTTP client, and Dio adapter.
        - **`dependency_injector`**: Contains configuration files for the dependency injector adapter.
        - **`dio`**: Contains Dio adapter configurations.
        - **`http`**: Contains the HTTP abstraction layer that provides a uniform interface for accessing data from external sources.
  - **`module`**: Responsible for organizing it into modules, making it possible to add new modules if necessary in the future.
    - **`home`**: Main module that contains the structure for the correct visualization of the map.
      - **`external`**: Contains classes for external data sources and package drivers such as connectivity and geolocation.
      - **`infra`**: Responsible for providing basic support for the project, such as communication with external APIs and packages.
      - **`domain`**: Contains code that defines the project's domain, including requirements and business rules.
      - **`presentation`**: Contains the structure responsible for managing the user interface.
        - **`controller`**: Contains the code that manages the interaction between the user interface and the project's domain.
        - **`widgets`**: Contains user interface elements.


## Dependencies

The project depends on the following packages:

* `connectivity_plus` - Provides access to network connectivity, including internet and cellular network connectivity.
* `Dio` - An HTTP client for Dart that provides simple and flexible features for making HTTP requests.
* `geolocator` - Provides access to device GPS location.
* `mocktail` - A package for creating mocks and stubs for testing, which are simulated or predefined objects that can be used to test the behavior of a system without relying on real implementations.
* `coverage` - A package for measuring code coverage in tests, which is a measure of how many lines of code are executed by tests.

#### Dependency links: 
[connectivity_plus](https://pub.dev/packages/connectivity_plus) / [Dio](https://pub.dev/packages/dio) / [Geolocator](https://pub.dev/packages/geolocator) / [Mocktail](https://pub.dev/packages/mocktail) / [Coverage](https://pub.dev/packages/coverage) 


## App Environment

The application environment variables are setted by ```--dart-define``` strategy which allow us to catch environment variables in our Flutter app run or build.

At this development environment you can find ```--dart-define```values inside ```flutter_run.sh``` script and VsCode ```launch.json``` file:

**Security: API_KEY shown below will be deactivated soon**

```bash
flutter run -t lib/main.dart \
--dart-define=API_URL=http://ip-api.com/json/ \
--dart-define=API_KEY=AIzaSyAMJkHZYAdRyBykD5jRX13rXdCJKmx6hyQ
```


```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "emergency_map",
            "request": "launch",
            "type": "dart",
            "args": [
                "--dart-define=API_URL=http://ip-api.com/json/",
                "--dart-define=API_KEY=AIzaSyAMJkHZYAdRyBykD5jRX13rXdCJKmx6hyQ"
            ]
        }
    ]
}
```

But for production environments, put sensitive data such as our __API_KEY__ inside the application code is a serious security problem that can be resolved by:
- Set ```--dart-define```  production values only in the __CI environment__.
- Run __code obfuscation__ algorithms at production build time. [(Obfuscate Dart code)](https://docs.flutter.dev/deployment/obfuscate)

## Run the application

- Install [Flutter](https://docs.flutter.dev/get-started/install) (The project is using the __3.13.3__ version)
- Setup an Android device / emulator

Clone the project repository:
 
```bash
 $ git clone https://github.com/diogobh93/emergency-map
```

Open the project folder and run the following commands:
  
```bash
$ flutter pub get

$ bash flutter_run.sh
```

## App Tests

You can run the application Unit and Widget Tests by running the ```flutter_test_coverage.sh``` script wich will run all the tests, generate the __coverage/lcov.info__ and the __HTML report__.

- Note: on macOS you need to have lcov installed on your system (`brew install lcov`).

- Note: On Windows, you need to have lcov installed on your system, and in the environment settings. To install lcov, you'll need Chocolatey. If you don't have it, follow the installation instructions here: https://chocolatey.org/install. After installing Chocolatey, you can install lcov with the command (`choco install lcov --installargs "--add-to-path"`), which will both install and configure the environment variables.


### Responsive Widget Test ⚡️

In the project's test structure, there is the **`util`** folder that contains the **`variants_screens_sizes.dart`** file. This file is used to develop applications that respond to different screen sizes. By using this class, you can ensure that your application looks great and performs well on all devices. For more details about the implementation I created, you can check it out on [My Medium](https://medium.com/@diogobh93/flutter-responsive-widget-test-4adb11e3c992).


### Test coverage report

![coverage](https://github.com/diogobh93/emergency-map/assets/37723303/86e3e9c3-d1e1-497e-8968-bea57443e17f)