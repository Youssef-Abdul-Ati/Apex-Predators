import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decodeing Json Data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter { predactor in
                predactor.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { ApexPredator1, ApexPredator2 in
            if alphabetical {
                ApexPredator1.name < ApexPredator2.name
            } else {
                ApexPredator1.id < ApexPredator2.id
            }
        }
    }
    
    func filter(by type: predatorType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter { Predator in
                Predator.type == type
            }
        }
    }
}
