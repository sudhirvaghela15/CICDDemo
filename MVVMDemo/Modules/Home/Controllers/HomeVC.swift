//
//  HomeVC.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import UIKit

class HomeVC: BaseViewController<HomeVM> {
	
	@IBOutlet weak var tblViewArtworkList: UITableView!
	
	override func viewDidLoad() {
		self.viewModel = HomeVM(session: URLSessionHTTPClient(session: .shared))
		super.viewDidLoad()
		viewModel.page.value = 0
		tblArtworkListConfiguration()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		UIView.setAnimationsEnabled(false)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		UIView.setAnimationsEnabled(true)
	}
	
	override func setupBindings() {
		super.setupBindings()
		viewModel.page.bind {[weak self] pageNumber in
			self?.viewModel.getArtwokrFromRemote()
		}
		
		viewModel.homeFeedList.bind {[weak self] homeVMList in
			DispatchQueue.main.async {
				self?.tblViewArtworkList.reloadData()
			}
		}
	}
	
	deinit {
		debugPrint("---- Deinit  Home VC ------")
	}
}


// MARK: - Custom functions
extension HomeVC {
	private func updateLayout() {
		tblViewArtworkList.beginUpdates()
		tblViewArtworkList.endUpdates()
	}
	func tblArtworkListConfiguration(){
		tblViewArtworkList.delegate = self
		tblViewArtworkList.dataSource = self
		tblViewArtworkList.register(HomeFeedTVC.nibID(), forCellReuseIdentifier: HomeFeedTVC.identifier)
	}
	
	
	
}

//MARK: - Delegate
extension HomeVC : UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
}
//MARK: - Datasource
extension HomeVC : UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.homeFeedList.value.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeFeedTVC.identifier, for: indexPath) as? HomeFeedTVC else {
			return UITableViewCell()
		}
		let viewModel = viewModel.homeFeedList.value[indexPath.item]
		cell.viewModel = viewModel
		return cell
	}
}
