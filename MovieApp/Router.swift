import UIKit

class Router{
    
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(in window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showTabBarController()
    }
    
    func showTabBarController() {
        let tabBarController = TabBarController()
        let movieDataSource = MovieDataSource()
        let movieCategoriesListViewModel = MovieCategoriesListViewModel(dataSource: movieDataSource, networkService: NetworkService())
        let movieCategoriesListController = MovieCategoriesListViewControllerMVVM(viewModel: movieCategoriesListViewModel, router: self)
        let movieCategoriesListNavigationController = UINavigationController(rootViewController: movieCategoriesListController)
        movieCategoriesListNavigationController.tabBarItem = UITabBarItem(title: "Movie List", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let favoritesViewController = FavoritesViewController()
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        tabBarController.viewControllers = [movieCategoriesListNavigationController, favoritesNavigationController]
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    func showMovieCategoriesList() {
        let movieDataSource = MovieDataSource()
        let movieCategoriesListViewModel = MovieCategoriesListViewModel(dataSource: movieDataSource, networkService: NetworkService())
        let vc = MovieCategoriesListViewControllerMVVM(viewModel: movieCategoriesListViewModel, router: self)
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func showMovieDetails(movieID: Int) {
        guard
            let currentViewController = navigationController.topViewController as? TabBarController,
            let navigationController = currentViewController.selectedViewController as? UINavigationController
        else { return }
        
        let movieDataSource = MovieDataSource()
        let movieDetailsViewModel = MovieDetailsViewModel(dataSource: movieDataSource, movieID: movieID)
        let vc = MovieDetailsViewControllerMVVM(viewModel: movieDetailsViewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
