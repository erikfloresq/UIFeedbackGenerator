# UIFeedbackGenerator
Example for UIFeedbackGenerator

# The idea
```swift
// initialize a variable
var feedbackGenerator : UINotificationFeedbackGenerator? =  nil

// create a instance for notification (UIFeedbackGenerator have three subclass: UIImpactFeedbackGenerator, UISelectionFeedbackGenerator, UINotificationFeedbackGenerator)
self.feedbackGenerator = UINotificationFeedbackGenerator()

// Preparing the generator can reduce latency when triggering feedback
self.feedbackGenerator?.prepare()

// Each feedback generator subclass has a unique triggering method (Have three notifications: success, error and warning)
self.feedbackGenerator?.notificationOccurred(.success)

// If you no longer need a prepared generator, remove all references to the generator object and let the system deallocate it.
self.feedbackGenerator = nil
``
