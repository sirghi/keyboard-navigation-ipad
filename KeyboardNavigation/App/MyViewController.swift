
import UIKit
enum Pages: CaseIterable {
    case zero
    case one

    var index: Int {
        switch self {
        case .zero: 0
        case .one: 1
        }
    }
}

class MyViewController: UIViewController, UIPageViewControllerDataSource {
    private var pages: [Pages] = Pages.allCases

    lazy var pager: UIPageViewController = {
        let pager = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .vertical)
        pager.dataSource = self
        pager.view.backgroundColor = .green
        return pager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        addChild(pager)
        view.addSubview(pager.view)
        let initialVC = PageViewController(with: pages[0])
        pager.setViewControllers([initialVC], direction: .forward, animated: true)
        pager.didMove(toParent: self)
        pager.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pager.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            pager.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            pager.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pager.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // We put here a breakpoint and inspect focusability with UIFocusDebugger
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PageViewController else { return nil }
        var index = currentVC.page.index
        if index == 0 { return nil }
        index -= 1
        let vc = PageViewController(with: pages[index])
        return vc
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PageViewController else { return nil }
        var index = currentVC.page.index
        if index >= self.pages.count - 1 { return nil }
        index += 1
        let vc = PageViewController(with: pages[index])
        return vc
    }
}

class PageViewController: UIViewController {
    var page: Pages

    init(with page: Pages) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
        self.focusGroupIdentifier = "page.controller"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        let focusableView = FocusableView()
        focusableView.focusGroupIdentifier = "focusable.view"
        focusableView.backgroundColor = .red
        view.addSubview(focusableView)
        focusableView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "Index: \(page.index)"
        label.translatesAutoresizingMaskIntoConstraints = false
        focusableView.addSubview(label)

        NSLayoutConstraint.activate([
            focusableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            focusableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            focusableView.heightAnchor.constraint(equalToConstant: 200),
            focusableView.widthAnchor.constraint(equalToConstant: 200),
            label.centerXAnchor.constraint(equalTo: focusableView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: focusableView.centerYAnchor),
        ])
    }
}
