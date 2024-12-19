import SwiftUI


struct ContentView: View {
    
    @State private var isNight = false
    @StateObject private var networkService = NetworkService()
    
    let weatherData = [
        WeatherDayView(dayOfWeek: "TUE",
                       imageName: "cloud.sun.fill",
                       temperature: 74),
        WeatherDayView(dayOfWeek: "WED",
                       imageName: "sun.max.fill",
                       temperature: 74),
        WeatherDayView(dayOfWeek: "THU",
                       imageName: "wind.snow",
                       temperature: 74),
        WeatherDayView(dayOfWeek: "FRI",
                       imageName: "snow",
                       temperature: 74),
        WeatherDayView(dayOfWeek: "SAT",
                       imageName: "sun.max.fill",
                       temperature: 74)
    ]
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            VStack {
                CityTextView(cityName: "Cupertino, CA")
                MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" :"cloud.sun.fill", temperature: 76)
                HStack(spacing: 20) {
                    ForEach(weatherData, id: \.dayOfWeek) { day in
                        WeatherDayView(dayOfWeek: day.dayOfWeek,
                                       imageName: day.imageName,
                                       temperature: day.temperature)
                    }
                }
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change day time",
                                  textColor: .blue,
                                  backgroundColor: .white)
                }
     
                Spacer()
                VStack {
                    Text("Данные с сервера")
                        .font(.headline)
                        .padding(.top)
                    if let errorMessage = networkService.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ScrollView {
                            Text(networkService.data)
                                .padding()
                        }
                           
                    }
                }
                Button {
                               networkService.getData()
                           } label: {
                               WeatherButton(title: "Load Server Data",
                                             textColor: .white,
                                             backgroundColor: .blue)
                           }
                .background(Color.white.opacity(0.8))
                             .cornerRadius(10)
                             .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
