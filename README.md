[![license](https://img.shields.io/badge/license-MIT-success.svg?style=flat-square)](https://github.com/Algure/azstore/blob/master/LICENSE)
[![pub package](https://img.shields.io/pub/v/azstore.svg?color=success&style=flat-square)](https://pub.dartlang.org/packages/azstore)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-success.svg?style=flat-square)](https://github.com/Algure/azstore/pulls)

![EAZI GRID](https://user-images.githubusercontent.com/37802577/186935121-319f3f03-c356-4a95-8a54-1e2f2768f410.png)

Easy dynamic Flutter row to list/grid. Starts out as a row and resizes to a grid - scaling to
dimensions of parent widget.

## Features

- Width of parent widget must be explicitly defined. 
- Height automatically shrinks or expands to wrap parent widget if height of parent is left unspecified.
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


![ezgif com-gif-maker](https://user-images.githubusercontent.com/37802577/187007067-23ef244f-4e4d-4cd1-8942-5187c88e3a99.gif)


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
##### Widget Parameters
- `isScrollable`: makes resulting grid vertically scrollable if set to true.
- `horizontalAlignment`: aligns children in each row by any of the options defined in `EaziAlignment`.
- `verticalAlignment`: aligns grid rows vertically by any of the options in defined `EaziAlignment`.
- `children`: all children must be widgets with explicitly defined heights and widths.

>   enum EaziAlignment { start, center, end }

## Additional information

Feel free to open issues for feature requests. If you'd like to contribute, send a PR.

TODO: 🤔 HAVE FUN 😬
