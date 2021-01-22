
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
        } else {
            let firstVc = JokesListBuilder().build()
            let secondVc = APIWebViewBuilder().build()
            
            let firstNavController = UINavigationController(rootViewController:firstVc)
            let firstTabBarItem = UITabBarItem(title: "Jockes", image: UIImage(named: "list"), tag: 0)
            firstNavController.tabBarItem = firstTabBarItem
            
            let secondNavControler = UINavigationController(rootViewController: secondVc)
            let secondTabBarItem = UITabBarItem(title: "API", image: UIImage(named: "internet"), tag: 1)
            secondNavControler.tabBarItem = secondTabBarItem
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [firstNavController, secondNavControler]
            
            self.window = UIWindow()
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }
        return true
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    

}

