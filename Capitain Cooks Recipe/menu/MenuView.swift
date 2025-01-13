import SwiftUI
import StoreKit
import WebKit
struct MenuView: View {
    @State private var acaunt = false
    @State private var setings = false
    @State private var support = false
    @State private var selectedCategory: String = "breakfast"
    @State private var searchText: String = ""
    @State private var selectedTab: String = "home"
    @State private var selectedDish: Dish?
    @State private var showDetails = false
    @State private var isSearching: Bool = false
    @State var notifications = false
    @State private var savedDishes: [Dish] = []
    @State private var userName: String = UserDefaults.standard.string(forKey: "userName") ?? "Guest"
 
    @State private var avatar: String = "avatar9"
    @State private var username: String = "Guest"
   
    let categories = [
        Category(name: "breakfast", icon: "b1"),
        Category(name: "lunch", icon: "b2"),
        Category(name: "snacks", icon: "b3"),
        Category(name: "dinner", icon: "b4"),
        Category(name: "desert", icon: "b5")
    ]

    var recipesForSelectedCategory: [Dish] {
         switch selectedCategory {
         case "breakfast":
             return breakfastRecipes
         case "lunch":
             return lunchRecipes
         case "snacks":
             return snackRecipes
         case "dinner":
             return dinnerRecipes
         case "desert":
             return dessertRecipes
         default:
             return []
         }
     }
    
    let recommendedDishes = [
        Dish(name: "German Pancakes", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "br1"),
        Dish(name: "Bavarian Soft Pretzels", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "br2"),
        Dish(name: "German Cheese Pretzel Sticks (Käsestangen)", time: "40 min", kcal: "190 kcal", difficulty: "Medium", imageName: "sn1"),
        Dish(name: "German Sausage Rolls (Würstchen im Schlafrock)", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "sn2"),
        Dish(name: "German Beef Goulash", time: "2.5 h", kcal: "500 kcal", difficulty: "Medium", imageName: "lu1"),
        Dish(name: "Sauerbraten with Gravy", time: "3 h", kcal: "400 kcal", difficulty: "Advanced", imageName: "lu2"),
        
       
    ]

   
    let breakfastRecipes = [
        Dish(name: "German Pancakes", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "br1"),
        Dish(name: "Bavarian Soft Pretzels", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "br2"),
        Dish(name: "German Breakfast Rolls", time: "25 min", kcal: "180 kcal", difficulty: "Medium", imageName: "br3"),
        Dish(name: "Bircher Muesli", time: "15 min", kcal: "200 kcal", difficulty: "Easy", imageName: "br4"),
        Dish(name: "German Scrambled Eggs", time: "10 min", kcal: "150 kcal", difficulty: "Easy", imageName: "br5"),
        Dish(name: "German Rye Bread Toast with Quark and Herbs", time: "15 min", kcal: "150 kcal", difficulty: "Easy", imageName: "br6"),
        Dish(name: "German Apple Pancakes", time: "20 min", kcal: "250 kcal", difficulty: "Easy", imageName: "br7"),
        Dish(name: "German Potato Pancakes", time: "30 min", kcal: "220 kcal", difficulty: "Medium", imageName: "br8"),
        Dish(name: "Bavarian Weisswurst with Pretzel and Mustard", time: "30 min", kcal: "300 kcal", difficulty: "Easy", imageName: "br9"),
        Dish(name: "German Fruit Salad", time: "15 min", kcal: "150 kcal", difficulty: "Easy", imageName: "br10")
    ]
    
    let snackRecipes = [
        Dish(name: "German Cheese Pretzel Sticks (Käsestangen)", time: "40 min", kcal: "190 kcal", difficulty: "Medium", imageName: "sn1"),
        Dish(name: "German Sausage Rolls (Würstchen im Schlafrock)", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "sn2"),
        Dish(name: "Bavarian Obatzda Spread", time: "15 min", kcal: "300 kcal", difficulty: "Easy", imageName: "sn3"),
        Dish(name: "German Potato Salad Cups (Kartoffelsalat im Glas)", time: "25 min", kcal: "350 kcal", difficulty: "Medium", imageName: "sn4"),
        Dish(name: "German Apple Strudel Bites (Apfelstrudel Bissen)", time: "35 min", kcal: "280 kcal", difficulty: "Hard", imageName: "sn5"),
        Dish(name: "German Pickled Vegetables (Eingelegtes Gemüse)", time: "20 min", kcal: "90 kcal", difficulty: "Easy", imageName: "sn6"),
        Dish(name: "German Cucumber Salad (Gurkensalat)", time: "10 min", kcal: "70 kcal", difficulty: "Easy", imageName: "sn7"),
        Dish(name: "Mini Black Forest Cupcakes (Schwarzwald Törtchen)", time: "45 min", kcal: "250 kcal", difficulty: "Medium", imageName: "sn8"),
        Dish(name: "German Rye Bread Crostini (Roggenbrot Crostini)", time: "20 min", kcal: "150 kcal", difficulty: "Easy", imageName: "sn9"),
        Dish(name: "German Ham and Cheese Rolls (Schinken-Käse Röllchen)", time: "25 min", kcal: "220 kcal", difficulty: "Easy", imageName: "sn10")
    ]
    
    let lunchRecipes = [
        Dish(name: "German Beef Goulash", time: "2.5 h", kcal: "500 kcal", difficulty: "Medium", imageName: "lu1"),
        Dish(name: "Sauerbraten with Gravy", time: "3 h", kcal: "400 kcal", difficulty: "Advanced", imageName: "lu2"),
        Dish(name: "Bratwurst with Mustard Sauce", time: "50 min", kcal: "300 kcal", difficulty: "Easy", imageName: "lu3"),
        Dish(name: "Bavarian Pork Roast (Schweinebraten)", time: "5 h", kcal: "450 kcal", difficulty: "Medium", imageName: "lu4"),
        Dish(name: "Königsberger Klopse (German Meatballs in White Sauce)", time: "1 h", kcal: "250 kcal", difficulty: "Medium", imageName: "lu5"),
        Dish(name: "Potato Salad (Kartoffelsalat)", time: "1 h", kcal: "250 kcal", difficulty: "Easy", imageName: "lu6"),
        Dish(name: "German Cabbage Rolls (Kohlrouladen)", time: "1 h 30 min", kcal: "350 kcal", difficulty: "Medium", imageName: "lu7"),
        Dish(name: "German Chicken Schnitzel (Hähnchen Schnitzel)", time: "30 min", kcal: "300 kcal", difficulty: "Easy", imageName: "lu8"),
        Dish(name: "German Lentil Soup (Linsensuppe)", time: "1 h 15 min", kcal: "280 kcal", difficulty: "Medium", imageName: "lu9"),
        Dish(name: "German Fish Fillet with Dill Sauce (Fischfilet mit Dillsauce)", time: "45 min", kcal: "350 kcal", difficulty: "Easy", imageName: "lu10")
    ]
    
    let dinnerRecipes = [
        Dish(name: "German Sauerkraut and Pork Sausage Bake (Sauerkraut mit Bratwurst im Ofen)", time: "1 h 20 min", kcal: "500 kcal", difficulty: "Medium", imageName: "di1"),
        Dish(name: "German Spätzle (Spätzle)", time: "45 min", kcal: "300 kcal", difficulty: "Medium", imageName: "di2"),
        Dish(name: "German Potato Dumplings (Kartoffelknödel)", time: "1 h", kcal: "250 kcal", difficulty: "Medium", imageName: "di3"),
        Dish(name: "German Onion Cake (Zwiebelkuchen)", time: "1 h 15 min", kcal: "320 kcal", difficulty: "Medium", imageName: "di4"),
        Dish(name: "German Stuffed Bell Peppers (Gefüllte Paprika)", time: "1 h", kcal: "300 kcal", difficulty: "Medium", imageName: "di5"),
        Dish(name: "German Hunter's Stew (Jägersuppe)", time: "1 h", kcal: "400 kcal", difficulty: "Medium", imageName: "di6"),
        Dish(name: "Bavarian Roast Pork (Schweinebraten)", time: "2 h 30 min", kcal: "800 kcal", difficulty: "Medium", imageName: "di7"),
        Dish(name: "German Cabbage Rolls", time: "1 h 20 min", kcal: "350 kcal", difficulty: "Medium", imageName: "di8"),
        Dish(name: "Sauerbraten (German Pot Roast)", time: "5 h", kcal: "450 kcal", difficulty: "Advanced", imageName: "di9"),
        Dish(name: "German Fried Potatoes (Bratkartoffeln)", time: "50 min", kcal: "250 kcal", difficulty: "Easy", imageName: "di10")
    ]
    
    let dessertRecipes = [
        Dish(name: "German Almond Cookies (Mandelplätzchen)", time: "30 min", kcal: "120 kcal", difficulty: "Easy", imageName: "des1"),
        Dish(name: "Bee Sting Cake (Bienenstich)", time: "2 h 30 min", kcal: "400 kcal", difficulty: "Advanced", imageName: "des2"),
        Dish(name: "Black Forest Cherry Cake (Schwarzwälder Kirschtorte)", time: "2 h", kcal: "450 kcal", difficulty: "Advanced", imageName: "des3"),
        Dish(name: "German Apple Pancakes (Apfelpfannkuchen)", time: "30 min", kcal: "180 kcal", difficulty: "Easy", imageName: "des4"),
        Dish(name: "German Plum Cake (Zwetschgenkuchen)", time: "1 h 20 min", kcal: "220 kcal", difficulty: "Medium", imageName: "des5"),
        Dish(name: "Vanilla Pudding with Red Berry Sauce (Rote Grütze)", time: "20 min", kcal: "190 kcal", difficulty: "Easy", imageName: "des6"),
        Dish(name: "Marzipan Potatoes (Marzipankartoffeln)", time: "15 min", kcal: "100 kcal", difficulty: "Easy", imageName: "des7"),
        Dish(name: "Cherry Crumble (Kirschstreuselkuchen)", time: "1 h", kcal: "300 kcal", difficulty: "Medium", imageName: "des8"),
        Dish(name: "Berlin Doughnuts (Berliner)", time: "2 h", kcal: "300 kcal", difficulty: "Advanced", imageName: "des9"),
        Dish(name: "German Cheesecake (Käsekuchen)", time: "1 h 30 min", kcal: "350 kcal", difficulty: "Medium", imageName: "des10")
    ]
    
    var allDishes: [Dish] {
          breakfastRecipes + lunchRecipes + snackRecipes + dinnerRecipes + dessertRecipes
      }

      var filteredDishes: [Dish] {
          if searchText.isEmpty {
              return []
          }
          return allDishes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
      }

    var body: some View {
        ZStack {
          
            Color("backg")
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
           
               

                if selectedTab == "home" {
                    homeView
                } else if selectedTab == "recipes" {
                    recipesView
                }else if selectedTab == "favorites" {
                    favoritesView
                }else if selectedTab == "profile" {
                    profileView
                }

                Spacer()

                bottomNav
            }
        }.fullScreenCover(item: $selectedDish) { dish in
            getDetailView(for: dish, savedDishes: $savedDishes)
        }
        .fullScreenCover(isPresented: $acaunt) {
            AccountView()
        }
        .fullScreenCover(isPresented: $notifications) {
           NotificationsView()
       }
        .fullScreenCover(isPresented: $setings) {
            SettingsView()
       }
        .fullScreenCover(isPresented: $support) {
            SupportView()
       }
        .onAppear {
            loadUserData()
        }
    }




    
    var homeView: some View {
        
        VStack(spacing: 4) {
            HStack {
                Image(avatar)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())


                VStack(alignment: .leading) {
                    Text("Hi, \(UserDefaults.standard.string(forKey: "userName") ?? "Guest")")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                    Text(getCurrentDate())
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }

                Spacer()

                Button(action: {
                    notifications.toggle()
                }) {
                    Image(systemName: "bell")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
            .padding()
            Text("What are you going to cook?")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal)

        
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                ForEach(categories) { category in
                    Button(action: {
                        selectedTab = "recipes"
                        selectedCategory = category.name
                    }) {
                        HStack {
                            Image(category.icon)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 5)

                            Text(category.name.capitalized)
                                .font(.subheadline)
                                .foregroundColor(selectedCategory == category.name ? .white : .white)
                        }
                        .padding(10)
                        .background(selectedCategory == category.name ? Color("pink") : Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)

           
            VStack(alignment: .leading) {
                HStack {
                    TextField("Search for recipes...", text: $searchText)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("pink"))
                    }
                }
                .padding()
                
                if !filteredDishes.isEmpty {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(filteredDishes) { dish in
                            Button(action: {
                                selectedDish = dish
                                searchText = ""
                            }) {
                                HStack {
                                    Text(dish.name)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color("pink").opacity(0.8))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }}
     

          
            VStack(alignment: .leading) {
                HStack {
                    Text("Recommended")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                    Button("See All") {
                        selectedTab = "recipes"
                    }
                    .foregroundColor(Color("pink"))
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(recommendedDishes) { dish in
                            Button(action: {
                                if selectedDish?.id != dish.id {
                                       selectedDish = dish
                                   }
                                   showDetails = true
                            }) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Image(dish.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 200, height: 150)
                                        .cornerRadius(15)
                                    
                                    Text(dish.name)
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                    HStack(spacing: 8) {
                                        Image("g1")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                        Text(dish.time)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                        
                                        Image("g2")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                        Text(dish.kcal)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                        
                                        Image("g3")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                        Text(dish.difficulty)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                                .frame(width: 200)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(20)
                                .shadow(radius: 5)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
               
            }
        }
    }

   
    var recipesView: some View {
        VStack{
            VStack(alignment: .leading, spacing: 20) {
                Text("Recipes")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                ForEach(categories) { category in
                    Button(action: {
                        selectedCategory = category.name
                        
                    }) {
                        HStack {
                            Image(category.icon)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 5)

                            Text(category.name.capitalized)
                                .font(.subheadline)
                                .foregroundColor(selectedCategory == category.name ? .white : .white)
                        }
                        .padding(10)
                        .background(selectedCategory == category.name ? Color("pink") : Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
                ScrollView {
                    ForEach(recipesForSelectedCategory) { dish in
                        Button(action: {
                            selectedDish = dish
                                       showDetails = true
                        }) {
                            VStack(alignment: .leading) {
                                Image(dish.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 390, height: 200)
                                    
                                    .cornerRadius(15)
                                
                                Text(dish.name)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.top, 8)
                                    .padding(.horizontal)
                                
                                HStack(spacing: 8) {
                                    Image("g1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                    Text(dish.time)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    
                                    Image("g2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                    Text(dish.kcal)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    
                                    Image("g3")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                    Text(dish.difficulty)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                            }
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(20)
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                
                }
            }
        }
    }
    
    var favoritesView: some View {
         VStack {
             Text("Favorites")
                 .font(.largeTitle)
                 .bold()
                 .foregroundColor(.white)
                 .padding()

             if savedDishes.isEmpty {
                 Text("No favorites yet!")
                     .foregroundColor(.gray)
                     .font(.headline)
             } else {
                 ScrollView {
                     ForEach(savedDishes) { dish in
                         Button(action: {
                             selectedDish = dish
                         }) {
                             RecipeCard(dish: dish)
                         }
                     }
                 }
             }
         }
     }
    struct RecipeCard: View {
        let dish: Dish

        var body: some View {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Image(dish.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 390, height: 200)
                    
                        .cornerRadius(15)
                    
                    Text(dish.name)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 8)
                        .padding(.horizontal)
                    
                    HStack(spacing: 8) {
                        Image("g1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                        Text(dish.time)
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        Image("g2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                        Text(dish.kcal)
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        Image("g3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                        Text(dish.difficulty)
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 8)}
            }
            .background(Color.white.opacity(0.1))
            .cornerRadius(20)
            .padding(.horizontal)
        }
    }
  
    var bottomNav: some View {
        HStack(spacing: 20) {
            BottomNavButton(image: "house.fill", title: "Home", isSelected: selectedTab == "home") {
                selectedTab = "home"
            }

            BottomNavButton(image: "fork.knife", title: "Recipes", isSelected: selectedTab == "recipes") {
                selectedTab = "recipes"
            }

            BottomNavButton(image: "bookmark.fill", title: "Favorites", isSelected: selectedTab == "favorites") {
                selectedTab = "favorites"
            }

            BottomNavButton(image: "person.fill", title: "Profile", isSelected: selectedTab == "profile") {
                selectedTab = "profile"
            }
        }
        .padding()
        .background(Color("pink"))
        .cornerRadius(30)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    
 
    var profileView: some View {
        VStack(spacing: 3) {
            HStack{
            Text("Profile")
                .bold()
                .foregroundColor(.white)
            Spacer()
        }

        
            Image(avatar)
                .resizable()
                .frame(width: 140, height: 140)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("pink"), lineWidth: 4))
                .shadow(radius: 10)
         

           
            HStack {
                if userName != "Guest" {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                Text(userName)
                    .fontWeight(.bold)
                    .foregroundColor(userName == "Guest" ? .orange : .white)
                if userName != "Guest" {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(userName == "Guest" ? Color.orange : Color("pink"), lineWidth: 2)
            )
            .background(Color.clear)
            .padding(.horizontal, 60)
            .padding(.bottom, 20)

            
            VStack(alignment: .leading, spacing: 10) {
                profileOptionRow(title: "Settings", action: {
                    setings.toggle()
                })
                profileOptionRow(title: "Rate App", action: {
                    if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                        AppStore.requestReview(in: scene)
                    }
                })
                profileOptionRow(title: "Support", action: {
                    support.toggle()
                })
                profileOptionRow(title: "Log Out", action: {
                    UserDefaults.standard.set(false, forKey: "log")
                    acaunt.toggle()
                })
                profileOptionRow(title: "Delete Profile", action: {
                    
                    let defaults = UserDefaults.standard
                      defaults.removeObject(forKey: "userName")
                      defaults.removeObject(forKey: "userAvatar")
                      defaults.removeObject(forKey: "log")
                    
                      defaults.synchronize()
                    acaunt.toggle()
                })
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(20)
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }

    func profileOptionRow(title: String, isDestructive: Bool = false, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .foregroundColor(isDestructive ? .red : .white)
                        .font(.headline)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(isDestructive ? .red : .white)
                        .font(.title3)
                }
                .padding(.vertical, 12)

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.pink.opacity(0.5))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    private func loadUserData() {
        avatar = UserDefaults.standard.string(forKey: "userAvatar") ?? "avatar9"
        print(avatar)
        username = UserDefaults.standard.string(forKey: "userName") ?? "Guest"
    }
    
    private func getCurrentDate() -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "MMM dd, EEE"
         return dateFormatter.string(from: Date())
     }
}


struct BottomNavButton: View {
    let image: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : .black)
                if isSelected {
                    Text(title)
                        .font(.system(size: 14))
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding(isSelected ? 10 : 0)
            .background(isSelected ? Color.black.opacity(0.2) : Color.clear)
            .cornerRadius(isSelected ? 20 : 0)
        }
    }
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}

struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let time: String
    let kcal: String
    let difficulty: String
    let imageName: String
}
@ViewBuilder
func getDetailView(for dish: Dish, savedDishes: Binding<[Dish]>) -> some View {
    switch dish.name {
    
    case "German Pancakes":
        RecipeDetailsView1(dish: dish, savedDishes: savedDishes)
    case "Bavarian Soft Pretzels":
        RecipeDetailsView2(dish: dish, savedDishes: savedDishes)
    case "German Breakfast Rolls":
        RecipeDetailsView3(dish: dish, savedDishes: savedDishes)
    case "Bircher Muesli":
        RecipeDetailsView4(dish: dish, savedDishes: savedDishes)
    case "German Scrambled Eggs":
        RecipeDetailsView5(dish: dish, savedDishes: savedDishes)
    case "German Rye Bread Toast with Quark and Herbs":
        RecipeDetailsView6(dish: dish, savedDishes: savedDishes)
    case "German Apple Pancakes":
        RecipeDetailsView7(dish: dish, savedDishes: savedDishes)
    case "German Potato Pancakes":
        RecipeDetailsView8(dish: dish, savedDishes: savedDishes)
    case "Bavarian Weisswurst with Pretzel and Mustard":
        RecipeDetailsView9(dish: dish, savedDishes: savedDishes)
    case "German Fruit Salad":
        RecipeDetailsView10(dish: dish, savedDishes: savedDishes)

  
    case "German Cheese Pretzel Sticks (Käsestangen)":
        RecipeDetailsView11(dish: dish, savedDishes: savedDishes)
    case "German Sausage Rolls (Würstchen im Schlafrock)":
        RecipeDetailsView12(dish: dish, savedDishes: savedDishes)
    case "Bavarian Obatzda Spread":
        RecipeDetailsView13(dish: dish, savedDishes: savedDishes)
    case "German Potato Salad Cups (Kartoffelsalat im Glas)":
        RecipeDetailsView14(dish: dish, savedDishes: savedDishes)
    case "German Apple Strudel Bites (Apfelstrudel Bissen)":
        RecipeDetailsView15(dish: dish, savedDishes: savedDishes)
    case "German Pickled Vegetables (Eingelegtes Gemüse)":
        RecipeDetailsView16(dish: dish, savedDishes: savedDishes)
    case "German Cucumber Salad (Gurkensalat)":
        RecipeDetailsView17(dish: dish, savedDishes: savedDishes)
    case "Mini Black Forest Cupcakes (Schwarzwald Törtchen)":
        RecipeDetailsView18(dish: dish, savedDishes: savedDishes)
    case "German Rye Bread Crostini (Roggenbrot Crostini)":
        RecipeDetailsView19(dish: dish, savedDishes: savedDishes)
    case "German Ham and Cheese Rolls (Schinken-Käse Röllchen)":
        RecipeDetailsView20(dish: dish, savedDishes: savedDishes)

   
    case "German Beef Goulash":
        RecipeDetailsView21(dish: dish, savedDishes: savedDishes)
    case "Sauerbraten with Gravy":
        RecipeDetailsView22(dish: dish, savedDishes: savedDishes)
    case "Bratwurst with Mustard Sauce":
        RecipeDetailsView23(dish: dish, savedDishes: savedDishes)
    case "Bavarian Pork Roast (Schweinebraten)":
        RecipeDetailsView24(dish: dish, savedDishes: savedDishes)
    case "Königsberger Klopse (German Meatballs in White Sauce)":
        RecipeDetailsView25(dish: dish, savedDishes: savedDishes)
    case "Potato Salad (Kartoffelsalat)":
        RecipeDetailsView26(dish: dish, savedDishes: savedDishes)
    case "German Cabbage Rolls (Kohlrouladen)":
        RecipeDetailsView27(dish: dish, savedDishes: savedDishes)
    case "German Chicken Schnitzel (Hähnchen Schnitzel)":
        RecipeDetailsView28(dish: dish, savedDishes: savedDishes)
    case "German Lentil Soup (Linsensuppe)":
        RecipeDetailsView29(dish: dish, savedDishes: savedDishes)
    case "German Fish Fillet with Dill Sauce (Fischfilet mit Dillsauce)":
        RecipeDetailsView30(dish: dish, savedDishes: savedDishes)


    case "German Sauerkraut and Pork Sausage Bake (Sauerkraut mit Bratwurst im Ofen)":
        RecipeDetailsView31(dish: dish, savedDishes: savedDishes)
    case "German Spätzle (Spätzle)":
        RecipeDetailsView32(dish: dish, savedDishes: savedDishes)
    case "German Potato Dumplings (Kartoffelknödel)":
        RecipeDetailsView33(dish: dish, savedDishes: savedDishes)
    case "German Onion Cake (Zwiebelkuchen)":
        RecipeDetailsView34(dish: dish, savedDishes: savedDishes)
    case "German Stuffed Bell Peppers (Gefüllte Paprika)":
        RecipeDetailsView35(dish: dish, savedDishes: savedDishes)
    case "German Hunter's Stew (Jägersuppe)":
        RecipeDetailsView36(dish: dish, savedDishes: savedDishes)
    case "Bavarian Roast Pork (Schweinebraten)":
        RecipeDetailsView37(dish: dish, savedDishes: savedDishes)
    case "German Cabbage Rolls ":
        RecipeDetailsView38(dish: dish, savedDishes: savedDishes)
    case "Sauerbraten (German Pot Roast)":
        RecipeDetailsView39(dish: dish, savedDishes: savedDishes)
    case "German Fried Potatoes (Bratkartoffeln)":
        RecipeDetailsView40(dish: dish, savedDishes: savedDishes)

 
    case "German Almond Cookies (Mandelplätzchen)":
        RecipeDetailsView41(dish: dish, savedDishes: savedDishes)
    case "Bee Sting Cake (Bienenstich)":
        RecipeDetailsView42(dish: dish, savedDishes: savedDishes)
    case "Black Forest Cherry Cake (Schwarzwälder Kirschtorte)":
        RecipeDetailsView43(dish: dish, savedDishes: savedDishes)
    case "German Apple Pancakes (Apfelpfannkuchen)":
        RecipeDetailsView44(dish: dish, savedDishes: savedDishes)
    case "German Plum Cake (Zwetschgenkuchen)":
        RecipeDetailsView45(dish: dish, savedDishes: savedDishes)
    case "Vanilla Pudding with Red Berry Sauce (Rote Grütze)":
        RecipeDetailsView46(dish: dish, savedDishes: savedDishes)
    case "Marzipan Potatoes (Marzipankartoffeln)":
        RecipeDetailsView47(dish: dish, savedDishes: savedDishes)
    case "Cherry Crumble (Kirschstreuselkuchen)":
        RecipeDetailsView48(dish: dish, savedDishes: savedDishes)
    case "Berlin Doughnuts (Berliner)":
        RecipeDetailsView49(dish: dish, savedDishes: savedDishes)
    case "German Cheesecake (Käsekuchen)":
        RecipeDetailsView50(dish: dish, savedDishes: savedDishes)

 
    default:
        Text("Details not found")
            .font(.headline)
            .foregroundColor(.white)
    }
}

#Preview {
    MenuView()
}
