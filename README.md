

## Making Your First Result Builder
```swift
// 1
@resultBuilder
// 2
enum CipherBuilder {
  // 3
  static func buildBlock(_ components: String...) -> String {
    components
      .joined(separator: " ")
      .replacingOccurrences(of: "e", with: "🥚")
  }
}
```

1. Y@resultBuilder can annotate any type that allows a static method.
2. You’ve used an enum because CipherBuilder doesn’t need to have instances created. Instead, it only contains static methods.
3. You implement a static buildBlock(_:) function. This is the only requirement for a result builder. Your function takes any number of String arguments and returns a String containing all the arguments joined with a space and all instances of the letter e replaced with the egg emoji: 🥚.
