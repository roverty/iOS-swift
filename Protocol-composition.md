## Protocol composition for dependency injection

### The problem

```swift
protocol GestureProtocol {
    func didTap() // Original required method
    func didDoubleTap() // Then incorporated method
    func didLongPress() // Then incorporated method
}
```

The above:

* Is an example of a so call *Fat Interface (Protocol)*
  * An interface is called “fat” when has too many members/methods,  
  * which are not cohesive and contains more information than we really want

* Violates the `Interface Segregation Principle`

> Interface Segregation Principle (ISP):
>
> Clients should not be force to depend upon interfaces that they do not use.

The **happy path** is this:

```swift
class SuperButton: GestureProtocol {
    func didTap() {
        // send tap action
    }

    func didDoubleTap() {
        // send double tap action
    }

    func didLongPress() {
        // send long press action
    }
}
```

But, how about this: 

```swift
class SimpleButton: GestureProtocol {
    func didTap() {
        // send tap action
    }

    func didDoubleTap() { } // Not needed

    func didLongPress() { } // Not needed
}
```

### Solution

```swift
protocol TapProtocol {
    func didTap()
}

protocol DoubleTapProtocol {
    func didDoubleTap()
}

protocol LongPressProtocol {
    func didLongPress()
}

class SuperButton: TapProtocol, DoubleTapProtocol, LongPressProtocol {
    func didTap() {
        // send tap action
    }

    func didDoubleTap() {
        // send double tap action
    }

    func didLongPress() {
        // send long press action
    }
}

class PoorButton: TapProtocol {
    func didTap() {
        // send tap action
    }
}
```

#### Another example of ISP

```swift
class Video {
    var title: String = "My Video"
    var description: String = "This is a beautiful video"
    var author: String = "Marco Santarossa"
    var url: String = "https://marcosantadev.com/my_video"
    var duration: Int = 60
    var created: Date = Date()
    var update: Date = Date()
}

// We inject the Video class to a function

func play(video: Video) {
    // load the player UI
    // load the content at video.url
    // add video.title to the player UI title
    // update the player scrubber with video.duration
}
```

**Solution:**

```swift
protocol Playable {
    var title: String { get }
    var url: String { get }
    var duration: Int { get }
}

class Video: Playable {
    var title: String = "My Video"
    var description: String = "This is a beautiful video"
    var author: String = "Marco Santarossa"
    var url: String = "https://marcosantadev.com/my_video"
    var duration: Int = 60
    var created: Date = Date()
    var update: Date = Date()
}


func play(video: Playable) {
    // load the player UI
    // load the content at video.url
    // add video.title to the player UI title
    // update the player scrubber with video.duration
}
```

This even makes easier to perform **unit testing**

```swift
class StubPlayable: Playable {
    private(set) var isTitleRead = false

    var title: String {
        self.isTitleRead = true
        return "My Video"
    }

    var duration = 60
    var url: String = "https://marcosantadev.com/my_video"
}

func test_Play_IsUrlRead() {
    let stub = StubPlayable()

    play(video: stub)

    XCTAssertTrue(stub.isTitleRead)
}
```

### Dependency injection

* Explain about dependency injection
  * Injecting the class and not using concrete types

### Resources

* [Protocol composition (MarcoSantaDev)](https://www.marcosantadev.com/protocol-composition-swift/)
* [Solid principles (MarcoSantaDev)](https://www.marcosantadev.com/solid-principles-applied-swift/)
* [Dependency injection (CocoaCasts)](https://cocoacasts.com/dependency-injection-in-swift)