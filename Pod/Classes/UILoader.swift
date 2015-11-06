import UIKit


internal class UILoaderItem
{
    weak var item: UILoader?
    var count: Int = 0
    init(item: UILoader) {
        self.item = item
    }
}

internal var items = [UILoaderItem]()

internal func find(item: UILoader) -> UILoaderItem?
{
    for existing in items {
        if let tempItem = existing.item {
            if tempItem.isEqual(item) {
                return existing
            }
        }
    }
    return nil
}

internal func make(item: UILoader) -> UILoaderItem
{
    if let found = find(item) {
        return found
    }
    items.append(UILoaderItem(item: item))
    return items.last!
}


public protocol UILoader: NSObjectProtocol
{
    var loading: Bool { get set }
    weak var spinningThing: UIActivityIndicatorView? { get }
    func didChangeLoadingStatus(loading: Bool)
}


public extension UILoader
{
    public var loading: Bool {
        get {
            return make(self).count > 0
        }
        set {
            let oldValue = self.loading
            let loaderItem = make(self)
            
            var shouldNotify = false
            
            if newValue {
                shouldNotify = ++loaderItem.count == 1
            } else {
                shouldNotify = --loaderItem.count == 0
                if loaderItem.count < 0 {
                    loaderItem.count = 0
                }
            }
            
            if (newValue != oldValue && shouldNotify)
            {
                let status = self.notifyStatusChange
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    status(newValue)
                }
            }
        }
    }
    
    private func notifyStatusChange(newValue: Bool) {
        if newValue {
            self.spinningThing?.startAnimating()
        } else {
            self.spinningThing?.stopAnimating()
        }
        self.didChangeLoadingStatus(newValue)
    }
}
