

## Making Your First Result Builder

![image](https://github.com/YamamotoDesu/ResultBuilders/assets/47273077/1541ac0f-5012-4af0-9965-c63863861549)

```swift
@CipherBuilder
func buildEggCipherMessage() -> String {
  "A secret report within the guild."
  "4 planets have come to our attention"
  "regarding a plot that could jeopardize spice production."
}

```

```swift
body
  .onAppear {
    secret = buildEggCipherMessage()
  }
```

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

1. @resultBuilder can annotate any type that allows a static method.
2. You’ve used an enum because CipherBuilder doesn’t need to have instances created. Instead, it only contains static methods.
3. You implement a static buildBlock(_:) function. This is the only requirement for a result builder. Your function takes any number of String arguments and returns a String containing all the arguments joined with a space and all instances of the letter e replaced with the egg emoji: 🥚.


## Defining a Cipher Rule

![image](https://github.com/YamamotoDesu/ResultBuilders/assets/47273077/ed69151a-2f8f-45d6-a3c9-d798f3228602)

```swift
  body
    .onChange(of: message) { newValue in
      secret = processMessage(newValue)
    }
    .onChange(of: secretMode) { _ in
      secret = processMessage(message)
    }
  }

  func processMessage(_ value: String) -> String {
    let cipher = SuperSecretCipher(offset: 7)
    switch secretMode {
    case .encode:
      return cipher.cipherRule.encipher(value)
    case .decode:
      return cipher.cipherRule.decipher(value)
    }
  }

```
