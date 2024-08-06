# infinite_pageview

[PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html) but its infinite and can go left to the negatives!

Inspired by [infinite_listview](https://github.com/fluttercommunity/flutter_infinite_listview).

<img src="demo.gif" width="250" />

## Example:

```dart
InfinitePageView(
    itemBuilder: (context, index) => Container(
        color: Colors.blue,
        child: Center(
        child: Text(
            style: TextStyle(fontSize: 30, color: Colors.white),
            index.toString(),
        ),
    ),
)
```

