//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Kallas on 9/12/19.
//  Copyright © 2019 AK. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController, StoryboardInstantiable {
    
    var weatherDetailsViewModel : WeatherDetailsViewModelProtocol!
    var weatherDetailsModel: WeatherDetailsModel!
    
     @IBOutlet weak var dateTime_lbl: UILabel!
    
    @IBOutlet weak var temperature_sol_lbl: UILabel!
    @IBOutlet weak var temperature_2m_lbl: UILabel!
    @IBOutlet weak var temperature_500hpa_lbl: UILabel!
    @IBOutlet weak var temperature_850hpa_lbl: UILabel!
    @IBOutlet weak var pression_lbl: UILabel!
    @IBOutlet weak var pluie_lbl: UILabel!
    @IBOutlet weak var pluie_convective_lbl: UILabel!
    @IBOutlet weak var humidite_lbl: UILabel!
    @IBOutlet weak var vent_moyen_lbl: UILabel!
    @IBOutlet weak var vent_rafales_lbl: UILabel!
    @IBOutlet weak var vent_direction_lbl: UILabel!
    @IBOutlet weak var iso_zero_lbl: UILabel!
    @IBOutlet weak var risque_neige_lbl: UILabel!
    @IBOutlet weak var cape_lbl: UILabel!
    @IBOutlet weak var nebulosite_haute_lbl: UILabel!
    @IBOutlet weak var nebulosite_moyenne_lbl: UILabel!
    @IBOutlet weak var nebulosite_basse_lbl: UILabel!
    @IBOutlet weak var nebulosite_totale_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherDetailsViewModel.getWeatherDetailsObserver().bind { [weak self] (observer, weatherDetailsModel) in
        self?.setViewData(weatherDetailsModel: weatherDetailsModel)
        }
        weatherDetailsViewModel.getWeatherDetails()
        // Do any additional setup after loading the view.
    }
    
    func setViewData(weatherDetailsModel: WeatherDetailsModel){
        
        dateTime_lbl.text = weatherDetailsModel.dateTime
        temperature_sol_lbl.text = "\(weatherDetailsModel.temperature_sol)"
        temperature_2m_lbl.text = "\(weatherDetailsModel.temperature_2m)"
        temperature_500hpa_lbl.text = "\(weatherDetailsModel.temperature_500hpa)"
        temperature_850hpa_lbl.text = "\(weatherDetailsModel.temperature_850hpa)"
        pression_lbl.text = "\(weatherDetailsModel.pression)"
        pluie_lbl.text = "\(weatherDetailsModel.pluie)"
        pluie_convective_lbl.text = "\(weatherDetailsModel.pluieConvective)"
        humidite_lbl.text = "\(weatherDetailsModel.humidity)"
        vent_moyen_lbl.text = "\(weatherDetailsModel.ventMoyen)"
        vent_rafales_lbl.text = "\(weatherDetailsModel.ventRafales)"
        vent_direction_lbl.text = "\(weatherDetailsModel.ventDirection)"
        iso_zero_lbl.text = "\(weatherDetailsModel.isoZero)"
        risque_neige_lbl.text = weatherDetailsModel.risqueNeige
        cape_lbl.text = "\(weatherDetailsModel.cape)"
        nebulosite_haute_lbl.text = "\(weatherDetailsModel.nebulositeHaute)"
        nebulosite_moyenne_lbl.text = "\(weatherDetailsModel.nebulositeMoyenne)"
        nebulosite_basse_lbl.text = "\(weatherDetailsModel.nebulositeBasse)"
        nebulosite_totale_lbl.text = "\(weatherDetailsModel.nebulositeTotale)"
    }

    
    deinit {
        print("deinit called")
        weatherDetailsViewModel.clearObservers()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
