# infinite_pageview

![pub.dev](https://img.shields.io/pub/v/infinite_pageview.svg)

[PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html) but its infinite and can go left to the negatives!

Inspired by [infinite_listview](https://github.com/fluttercommunity/flutter_infinite_listview).


## Example

![Example](https://github.com/mkalmousli/flutter_infinite_pageview/raw/main/example.gif)

```bash
cd example
flutter run lib/main.dart
```


## Usage:

```dart
import 'package:infinite_pageview/infinite_pageview.dart';

InfinitePageView(
    itemBuilder: (context, index) => Container(
        color: Colors.blue,
        child: Center(
            child: Text(
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                ),
                index.toString(),
            ),
        ),
    )
)
```