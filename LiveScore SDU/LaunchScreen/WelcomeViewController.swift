//
//  WelcomeViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 12.04.2023.
//

//protocol PageProtocol {
//    var pageIndex: Int { get }
//}

//class WelcomeViewController: UIViewController {
//
//    var isFirstLaunch: Bool = true
//    var page3 = Page3ViewController()
//
//    private var pageViewController: UIPageViewController!
//    private var pageControl: UIPageControl!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
//
//        if isFirstLaunch {
//            // Show the UIPageViewController if it's the first launch
//            showPageViewController(from: self)
//        } else {
//            // Show the main view controller if it's not the first launch
//            showMainViewController(from: self)
//        }
//
//        setupPageViewController()
//
//        pageViewController.dataSource = self
//    }
//
//    func showPageViewController(from viewController: UIViewController) {
//        let mainViewController = WelcomeViewController()
//        viewController.present(mainViewController, animated: true, completion: nil)
//    }
//
//    func showMainViewController(from viewController: UIViewController) {
//        let mainViewController = MainViewController()
//        viewController.present(mainViewController, animated: true, completion: nil)
//    }
//
//    private func setupPageViewController() {
//        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//
//        let initialPage = 0
//        let page = [initialPage]
//        pageViewController.setViewControllers([viewControllerForPage(page: initialPage)], direction: .forward, animated: true, completion: nil)
//
//        addChild(pageViewController)
//        view.addSubview(pageViewController.view)
//        pageViewController.view.frame = view.bounds
//        pageViewController.view.backgroundColor = .orange
//        pageViewController.didMove(toParent: self)
//
//        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
//            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//
//    }
//
//    private func viewControllerForPage(page: Int) -> UIViewController {
//        switch page {
//        case 0:
//            return Page1ViewController()
//        case 1:
//            return Page2ViewController()
//        case 2:
//            return Page3ViewController()
//        default:
//            return UIViewController()
//        }
//    }
//}
//
//extension WelcomeViewController: UIPageViewControllerDataSource {
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let index = viewController as? PageProtocol else { return nil }
//        let previousIndex = index.pageIndex - 1
//        guard previousIndex >= 0 else { return nil }
//        return viewControllerForPage(page: previousIndex)
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let index = viewController as? PageProtocol else { return nil }
//        let nextIndex = index.pageIndex + 1
//        guard nextIndex < 3 else { return nil }
//        return viewControllerForPage(page: nextIndex)
//    }
//
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return 3
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard let currentViewController = pageViewController.viewControllers?.first as? PageProtocol else { return 0 }
//        return currentViewController.pageIndex
//    }
//}

import UIKit

class WelcomeViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        let page1 = Page1ViewController()
        let page2 = Page2ViewController()
        let page3 = Page3ViewController()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        page3.view.addGestureRecognizer(tapGesture)
                
        self.pages.append(page1)
        self.pages.append(page2)
        self.pages.append(page3)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)

        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.orange
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = initialPage
        self.view.addSubview(self.pageControl)

        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        
        if let page3 = self.pages.last {
            if let page3Content = page3 as? Page3ViewController {
                print("Tapped on Page 3: \(page3Content)")
                // Create an instance of the destination view controller
                let destinationVC = MainViewController()
                destinationVC.modalPresentationStyle = .overFullScreen
                // Push the destination view controller onto the navigation stack
                present(destinationVC, animated: true)
            }
        }
        
    }
    
//    private func viewControllerForPage(page: Int) -> UIViewController {
//        switch page {
//        case 0:
//            return Page1ViewController()
//        case 1:
//            return Page2ViewController()
//        case 2:
//            return Page3ViewController()
//        default:
//            return UIViewController()
//        }
//    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                return self.pages.last
            } else {
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
        
//        guard let index = viewController as? PageProtocol else { return nil }
//        let previousIndex = index.pageIndex - 1
//        guard previousIndex >= 0 else { return nil }
//        return viewControllerForPage(page: previousIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                return self.pages[viewControllerIndex + 1]
            } else {
                return self.pages.first
            }
        }
        return nil
        
//        guard let index = viewController as? PageProtocol else { return nil }
//        let nextIndex = index.pageIndex + 1
//        guard nextIndex < 3 else { return nil }
//        return viewControllerForPage(page: nextIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
}
