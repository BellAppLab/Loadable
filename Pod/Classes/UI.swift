import UIKit


class UILoaderView: UIView, UILoader
{
    var _loadingCount = 0
    var loading = false
    @IBOutlet weak var spinningThing: UIActivityIndicatorView?
    func didChangeLoadingStatus(loading: Bool) {
        
    }
}

class UILoaderViewController: UIViewController, UILoader
{
    var _loadingCount = 0
    var loading = false
    @IBOutlet weak var spinningThing: UIActivityIndicatorView?
    func didChangeLoadingStatus(loading: Bool) {
        
    }
}


class UILoaderTableViewController: UITableViewController, UILoader
{
    var _loadingCount = 0
    var loading = false
    @IBOutlet weak var spinningThing: UIActivityIndicatorView?
    func didChangeLoadingStatus(loading: Bool) {
        
    }
}


class UILoaderCollectionViewController: UICollectionViewController, UILoader
{
    var _loadingCount = 0
    var loading = false
    @IBOutlet weak var spinningThing: UIActivityIndicatorView?
    func didChangeLoadingStatus(loading: Bool) {
        
    }
}
