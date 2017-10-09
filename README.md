# UILoader

Make it easier to track the loading status of your objects.

_v0.7.0_

## Usage

Transform this:

```swift
class LameViewController: UIViewController
{
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView?

    private var isPerformingVeryLongBackgroundTask = false
    func performVeryLongBackgroundTask() {
        self.isPerformingVeryLongBackgroundTask = true
        self.activityIndicatorView?.startAnimating()
        doStuff { [weak self] _ in
            if self?.isPerformingOtherVeryLongBackgroundTask == false {
                self?.activityIndicatorView?.stopAnimating()
            }
            self?.isPerformingVeryLongBackgroundTask = false
        }
    }

    private var isPerformingOtherVeryLongBackgroundTask = false
    func performOtherVeryLongBackgroundTask() {
        self.isPerformingOtherVeryLongBackgroundTask = true
        self.activityIndicatorView?.startAnimating()
        doOtherStuff { [weak self] _ in
            if self?.isPerformingVeryLongBackgroundTask == false {
                self?.activityIndicatorView?.stopAnimating()
            }
            self?.isPerformingOtherVeryLongBackgroundTask = false
        }
    }
}
```

**Into this:**

```swift
class CoolViewController: UIViewController, UILoader
{
    func didChangeLoadingStatus(_ loading: Bool) {
        if loading {
            //if you have a `UIActivityIndicatorView`, it will automatically start animating
            //disable buttons
            //do all sorts of stuff to your UI while you're loading things
        } else {
            //stop loading!
            //get on with your life
        }
    }

    //optional
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView?

    func performVeryLongBackgroundTask() {
        self.isLoading = true
        doStuff { [weak self] _ in
            self?.isLoading = false
        }
    }

    func performOtherVeryLongBackgroundTask() {
        self.isLoading = true
        doOtherStuff { [weak self] _ in
            self?.isLoading = false
        }
    }
}
```

## Requirements

iOS 9.0+
Swift 3.2

## Installation

### Cocoapods

Because of [this](http://stackoverflow.com/questions/39637123/cocoapods-app-xcworkspace-does-not-exists), I've dropped support for Cocoapods on this repo. I cannot have production code rely on a dependency manager that breaks this badly.

### Git Submodules

**Why submodules, you ask?**

Following [this thread](http://stackoverflow.com/questions/31080284/adding-several-pods-increases-ios-app-launch-time-by-10-seconds#31573908) and other similar to it, and given that Cocoapods only works with Swift by adding the use_frameworks! directive, there's a strong case for not bloating the app up with too many frameworks. Although git submodules are a bit trickier to work with, the burden of adding dependencies should weigh on the developer, not on the user. :wink:

To install Backgroundable using git submodules:

```
cd toYourProjectsFolder
git submodule add -b submodule --name UILoader https://github.com/BellAppLab/UILoader.git
```

**Swift 2 support**

```
git submodule add -b swift2 --name UILoader https://github.com/BellAppLab/UILoader.git
```

Then, navigate to the new Backgroundable folder and drag the `Source` folder into your Xcode project.

## Author

Bell App Lab, apps@bellapplab.com

## License

Backgroundable is available under the MIT license. See the LICENSE file for more info.
