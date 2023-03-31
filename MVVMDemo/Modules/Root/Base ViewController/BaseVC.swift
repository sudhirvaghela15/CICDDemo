//
//  BaseVC.swift
//  MVVMDemo
//
//  Created by sudhir on 26/06/22.
//

import UIKit

class BaseViewController<VM: ViewModel>: UIViewController {
    var viewModel: VM!
    var loader: LoadingView?

//    init(viewModel: VM) {
//        super.init(nibName: nil, bundle: nil)
//        self.viewModel = viewModel
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
////        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loader = LoadingView()
		setupBindings()
    }

	func setupBindings() {
		viewModel.isLoadingPublisher.bind { [weak self] isLoading in
				isLoading ? self?.loader?.showLoadingView() : self?.loader?.hideLoadingView()
		}

		viewModel.errorPublisher?.bind { [weak self] error in
				let alertController = UIAlertController(title: "Localization.error", message: error.localizedDescription, preferredStyle: .alert)
				let okAction = UIAlertAction(title:" Localization.ok", style: .default, handler: nil)
				alertController.addAction(okAction)
				self?.present(alertController, animated: true, completion: nil)
		}
	}
    
    deinit {
        debugPrint("deinit of ", String(describing: self))
    }
}
