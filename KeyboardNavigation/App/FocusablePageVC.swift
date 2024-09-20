//
//  FocusablePageVC.swift
//  KeyboardNavigation
//
//  Created by Sergiu Todirascu on 20.09.2024.
//  Copyright © 2024 Apple. All rights reserved.
//

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

class FocusablePageViewController: UIPageViewController, UIPageViewControllerDataSource {
    private var pages: [Pages] = Pages.allCases

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override var keyCommands: [UIKeyCommand]? {
        let newCommands = [
            UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(handleUpArrow)),
            UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [], action: #selector(handleDownArrow)),
        ]
        newCommands.forEach {
            $0.wantsPriorityOverSystemBehavior = true
        }
        return newCommands
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        let initialVC = PageViewController(with: pages[0])
        setViewControllers([initialVC], direction: .forward, animated: true)
        view.focusEffect = UIFocusHaloEffect()
    }

    @objc private func handleUpArrow() {
        navigateToPage(direction: .reverse)
    }

    @objc private func handleDownArrow() {
        navigateToPage(direction: .forward)
    }

    private func navigateToPage(direction: UIPageViewController.NavigationDirection) {
        guard let currentVC = viewControllers?.first as? PageViewController else { return }
        guard let nextVC = self.pageViewController(self, viewControllerAfter: currentVC) else { return }
        setViewControllers([nextVC], direction: direction, animated: true)
    }

    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PageViewController else { return nil }
        let currentIndex = currentVC.page.index
        let previousIndex = (currentIndex - 1 + pages.count) % pages.count
        return PageViewController(with: pages[previousIndex])
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PageViewController else { return nil }
        let currentIndex = currentVC.page.index
        let nextIndex = (currentIndex + 1) % pages.count
        return PageViewController(with: pages[nextIndex])
    }
}
