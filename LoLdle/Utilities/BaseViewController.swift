//
//  BaseViewController.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 12/09/2022.
//

import UIKit
import RxSwift

/** `BaseViewController` is a class that every `UIViewController` inherits from.*/
class BaseViewController<T: UIView>: UIViewController, UIGestureRecognizerDelegate {
    /** The view that the controller manages cast to the set generic type. */
    var castView: T {
        return view as! T
    }
    
    let disposeBag = DisposeBag()
    
    private let activityOverlay: ActivityOverlay = {
        let overlay = ActivityOverlay()
        overlay.alpha = 0
        return overlay
    }()
    
    private let errorView: ErrorView = {
        let view = ErrorView()
        view.alpha = 0
        return view
    }()
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        let view = T()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        addKeyboardDismissTapRecognizer()
    }
    
    // MARK: - Internal
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func indicateProgress() {
        guard activityOverlay.superview == nil else { return }
        
        castView.addSubview(activityOverlay)
        activityOverlay.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.activityOverlay.alpha = 1.0
        }
    }
    
    func stopIndicatingProgress() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.activityOverlay.alpha = 0
        } completion: { _ in
            self.activityOverlay.removeFromSuperview()
        }
    }
    
    func presentErrorView(error: LoLdleError) {
        guard errorView.superview == nil else { return }
        Analytics.shared.trackErrorViewed(errorDescription: error.description, errorCode: error.code)
        dismissKeyboard()
        
        errorView.configure(withError: error)
        castView.addSubview(errorView)
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.errorView.alpha = 1.0
        } completion: { isCompleted in
            self.errorView.playAnimation()
        }
    }
    
    func hideErrorView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.errorView.alpha = 0
        } completion: { _ in
            self.errorView.removeFromSuperview()
        }
    }
    
    // MARK: - Private
    private func addKeyboardDismissTapRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        recognizer.cancelsTouchesInView = false
        recognizer.delegate = self
        view.addGestureRecognizer(recognizer)
    }
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view is UIButton)
    }
}
