import UIKit
// InitialViewController se nalazi u navigacijskom stogu UINavigationControllera
class FavoritesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .green
        appearance.titleTextAttributes = [.foregroundColor: UIColor(.white)]
        appearance.largeTitleTextAttributes = [.backgroundColor: UIColor(.white)]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        title = "Yellow"
    }
}
