
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let firstVc = JokesListBuilder().build()
        let secondVc = APIWebViewBuilder().build()
        
        let firstNavController = UINavigationController(rootViewController:firstVc)
        let firstTabBarItem = UITabBarItem(title: "Jockes", image: UIImage(systemName: "list.dash"), tag: 0)
        firstNavController.tabBarItem = firstTabBarItem
        
        let secondNavControler = UINavigationController(rootViewController: secondVc)
        let secondTabBarItem = UITabBarItem(title: "API", image: UIImage(systemName: "network"), tag: 1)
        secondNavControler.tabBarItem = secondTabBarItem
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstNavController, secondNavControler]
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
      
       
    }

    
}

