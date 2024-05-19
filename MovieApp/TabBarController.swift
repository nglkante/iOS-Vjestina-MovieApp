import UIKit

class TabBarController : UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        
        
        let movieCategoriesListController = MovieCategoriesListViewController(router: Router(navigationController: navigationController!))
        let movieCategoriesListNavigationController = UINavigationController(rootViewController: movieCategoriesListController)
        movieCategoriesListNavigationController.tabBarItem = UITabBarItem(title: "Movie List", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        let favoritesViewController = FavoritesViewController()
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        viewControllers = [movieCategoriesListNavigationController, favoritesNavigationController]
    }
}
