import UIKit


class ViewController: UIViewController, UILoader
{
    func didChangeLoadingStatus(_ loading: Bool) {
        if loading {
            print("We are loading now")
        } else {
            print("Stopped loading")
        }
    }
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView?
    
    @IBAction func startLoading(_ sender: AnyObject?) {
        self.isLoading = true
    }
    
    @IBAction func stopLoading(_ sender: AnyObject?) {
        self.isLoading = false
    }
}
