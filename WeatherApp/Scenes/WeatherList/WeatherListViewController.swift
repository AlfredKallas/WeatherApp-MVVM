//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kallas on 9/8/19.
//  Copyright © 2019 AK. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController, StoryboardInstantiable {

    var weatherListViewModel: WeatherListViewModelProtocol!
    private var signleWeatherDataCellViewModels = [SingleWeatherDataViewModel]()
    weak var coordiantor:WeatherListCoordinator!
    
    @IBOutlet var tableView : UITableView!
    // MARK: - Routes
    enum WeatherListRoute: String {
        case details
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        setupObserbales()
        weatherListViewModel.requestLocation()
    }
    
    func setupObserbales(){
        
        weatherListViewModel.getDidInsertObjectAtIndextPathObservable().bind { [weak self] (observer, cellViewModel) in
            
            guard let tableView = self?.tableView, let newIndexPath = cellViewModel.newIndexPath  else {
                return
            }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            self?.signleWeatherDataCellViewModels.append(SingleWeatherDataViewModel.from(weatherCellModel: cellViewModel.object))
        }
        
        weatherListViewModel.getDidDeleteObjectAtIndextPathObservable().bind { [weak self] (observer, object) in
            
            guard let tableView = self?.tableView, let indexPath = object.indexPath else {
                return
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.signleWeatherDataCellViewModels.remove(at: indexPath.row)
        }
        
        weatherListViewModel.getDidMoveObjectAtIndextPathObservable().bind { [weak self] (observer, cellViewModel) in
            
            guard let tableView = self?.tableView, let indexPath = cellViewModel.indexPath, let newIndexPath = cellViewModel.newIndexPath else {
                return
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            self?.signleWeatherDataCellViewModels.remove(at: indexPath.row)
            self?.signleWeatherDataCellViewModels.append(SingleWeatherDataViewModel.from(weatherCellModel: cellViewModel.object))

        }
        
        weatherListViewModel.getDidUpdateObjectAtIndextPathObservable().bind { [weak self] (observer, cellViewModel) in
            
            guard let tableView = self?.tableView, let indexPath = cellViewModel.indexPath else {
                return
            }
            //configure Cell
            if let cell = tableView.cellForRow(at: indexPath) as? WeatherDataCell {
                guard let singleWeatherDataViewModel = self?.signleWeatherDataCellViewModels[indexPath.row] else { return }
                
                cell.configureCell(singleWeatherDataViewModel: singleWeatherDataViewModel)
            }
        }
        
        weatherListViewModel.getWillChangeContentObservable().bind { [weak self] (observer, object) in
            
            guard let tableView = self?.tableView else { return }
            tableView.beginUpdates()
        }
        
        weatherListViewModel.getDidChangeContentObservable().bind { [weak self] (observer, object) in
            
            guard let tableView = self?.tableView else { return }
            tableView.endUpdates()
        }
        
        weatherListViewModel.getAlertControlleErrorObserver().bind { (observer, object) in
            UIAlertController.show(object.message, buttonTitle: object.actionButtonTitle, from: self.navigationController)
        }
        
        weatherListViewModel.getDidSelectCellAtIndexPathObservable().bind { [weak self](observable, weatherDetailsModel) in
            self?.coordiantor.goToDetails(weatherDetailsModel: weatherDetailsModel)
        }
    }
    
    deinit {
        weatherListViewModel?.clearObservers()
    }
}

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.getWeatherDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //variable type is inferred
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDataCell.cellIdentifier(), for: indexPath)
        
        // we know that cell is not empty now so we use ! to force unwrapping but you could also define cell as
        // let cell = (tableView.dequeue... as? UITableViewCell) ?? UITableViewCell(style: ...)
        if let cell = cell as? WeatherDataCell {
            let singleWeatherDataViewModel = cellViewModel(from: indexPath)
            cell.configureCell(singleWeatherDataViewModel: singleWeatherDataViewModel)
        }
        
        
        return cell
    }
    
    private func cellViewModel(from indexPath: IndexPath) -> SingleWeatherDataViewModel? {
        if(self.signleWeatherDataCellViewModels.count > indexPath.row){
            return self.signleWeatherDataCellViewModels[indexPath.row]
        }else{
            
            
            let weatherData = weatherListViewModel.getSingleWeather(at: indexPath)
            
            guard let unwrappedWeatherData = weatherData else {
                return nil
            }
            return weatherListViewModel.singleWeatherDataViewModel(from: unwrappedWeatherData)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = weatherListViewModel.getSingleWeather(at: indexPath) else {
            return
        }
        weatherListViewModel.didSelectCellAtIndexPath(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

