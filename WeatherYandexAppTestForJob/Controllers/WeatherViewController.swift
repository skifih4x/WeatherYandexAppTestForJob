//
//  WeatherViewController.swift
//  WeatherYandexAppTestForJob
//
//  Created by Артем Орлов on 21.07.2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UITableViewController {

    let emptyCity = Weather()
    
    var citiesArray = [Weather]()
    var filterCityArray = [Weather]()
    
    var nameCitiesArray = ["Москва", "Санкт-Петербург", "Уфа", "Новосибирск", "Челябинск", "Омск", "Екатеринбург", "Томск", "Сочи"]
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpt: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpt
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
        addCities()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    
    @IBAction func pressPlusButton(_ sender: Any) {
        alertPlusCity(name: "Город", placeholder: "Введите название города") { city in
            self.nameCitiesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
    }
    
    func addCities() {
        getCityWeather(citiesArray: self.nameCitiesArray) { index, weather in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitiesArray[index]
            print(self.citiesArray)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterCityArray.count
        }
        return citiesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell

        var weather = Weather()
        
        if isFiltering {
            weather = filterCityArray[indexPath.row]
        } else {
            weather = citiesArray[indexPath.row]
        }
        
        
        cell.configure(weather: weather)
        return cell
    }
    
    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deletaAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completion in
            let edidingRow = self.nameCitiesArray[indexPath.row]
            
            if let index = self.nameCitiesArray.firstIndex(of: edidingRow) {
                
                if self.isFiltering {
                    self.filterCityArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)
                }

            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deletaAction])
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            if isFiltering {
                let filter = filterCityArray[indexPath.row]
                guard let destinationVC = segue.destination as? DetailsViewController else { return }
                 destinationVC.weatherModel = filter
            } else {
                let cityWeather = citiesArray[indexPath.row]
              guard  let destinationVC = segue.destination as? DetailsViewController else { return }
                destinationVC.weatherModel = cityWeather
            }
        }
    }
}

//MARK: - SearchResult

extension WeatherViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filterCityArray = citiesArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}
