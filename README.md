<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for![EAZI GRID](https://user-images.githubusercontent.com/37802577/186935061-2673ca6b-0eda-4385-b619-1a273298d4b3.png)

[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
![EAZI GRID](https://user-images.githubusercontent.com/37802577/186935121-319f3f03-c356-4a95-8a54-1e2f2768f410.png)

Easy dynamic flutter row to list/gridview. Starts out as a row and resizes to a grid and ultimately to a list view depending on 
dimensions of containing widget.

## Features

- Width of parent widget must be explicitly defined. 
- Height automatically shrinks and expands to wrap parent widget if height of parent is left unspecified.
- Children can be made vertically scrollable if the parameter `isScrollable` is set to true.

## Getting started

Add package dependency to pubspec.yaml.
```yaml
dependencies:
  flutter:
    sdk: flutter

  ...
  eazigrid: ^[latest_version]
  ```
 
Resolve overflow issues for automated testing by adding the following line to the main method in the main flutter file as shown in the [example](https://github.com/Algure/eazigrid/blob/8b2cab3258a0a1fd33dcea268e47bb8b94b057ea/example/lib/main.dart#L6)
```dart
  EaziGridFlowHandler.handleEaziError();
```
## Usage


Declare `EaziGrid` in a parent widget with width != infinty (See [example](https://github.com/Algure/eazigrid/blob/8b2cab3258a0a1fd33dcea268e47bb8b94b057ea/example/lib/main.dart#L48))

```dart
EaziGrid(
  isScrollable: true,
  horizontalAlignment: EaziAlignment.start,
  children: [
  for(int i=0; i<=widget.totalItems; i++)
    TestGridItem(itemIndex: i)
])
```
### Widget Parameters
- `isScrollable`: Makes resulting grid vertically scrollable if set to true.
- `horizontalAlignment`: Aligns children in each row to any of the options in `EaziAlignment`.
- `verticalAlignment`: Aligns grid rows vertically to any of the options in  `EaziAlignment`.
- `children`: All children must be widgets with explicitly defined heights and widths.

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
