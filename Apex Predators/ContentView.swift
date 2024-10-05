import SwiftUI
import MapKit

struct ContentView: View {
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = predatorType.all
    var predators = Predators()
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack{
            List(filteredDinos){ predactor in
                NavigationLink{
                    PredatorDetail(predator: predactor, position: .camera(MapCamera(centerCoordinate: predactor.location, distance: 30000)))
                }label: {
                    HStack {
                        // Dinasaurs Image
                        Image(predactor.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack (alignment: .leading){
                            // Dinasaurs Text
                            Text(predactor.name)
                                .fontWeight(.bold)
                            // Dinasours Type
                            Text(predactor.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal,13)
                                .padding(.vertical,5)
                                .background(predactor.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.easeIn, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    }label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu{
                        Picker("filter",selection: $currentSelection.animation()){
                            ForEach(predatorType.allCases){ type in
                                Label(type.rawValue.capitalized,systemImage: type.icon)
                            }
                        }
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
