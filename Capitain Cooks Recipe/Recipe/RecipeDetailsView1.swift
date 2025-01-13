


import SwiftUI


struct RecipeDetailsView1: View {
    let dish: Dish
    @State private var rating: Int = 0
    @Environment(\.dismiss) var dismiss
    @State private var showFeedbackAlert = false
    @State private var isSaved = false
    @Binding var savedDishes: [Dish]
    @State private var showSaveMessage = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
             
                HStack {
                    Button {
                        self.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }

                    Spacer()

                    Text("Details")
                        .font(.headline)
                        .foregroundColor(.white)

                    Spacer()

                    Button {
                        if isSaved {
                            
                            savedDishes.removeAll { $0.id == dish.id }
                        } else {
                         
                            savedDishes.append(dish)
                            showSaveMessage = true
                           
                        }
                        isSaved.toggle()
                    } label: {
                        Image(systemName: "bookmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                }
                .padding(.top, 40)
                .background(Color("backg"))
                .alert(isPresented: $showSaveMessage) {
                        Alert(
                            title: Text("Recipe Saved"),
                            message: Text("The recipe \"\(dish.name)\" has been added to your saved recipes."),
                            dismissButton: .default(Text("OK"))
                        )
                    }

              
                Image(dish.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 250)
                    .clipped()
                    

                
                Text(dish.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal)

                
                HStack(spacing: 16) {
                    RecipeInfoView(icon: "g1", text: dish.time)
                    RecipeInfoView(icon: "g2", text: dish.kcal)
                    RecipeInfoView(icon: "g3", text: dish.difficulty)
                }
                .padding(.horizontal)

                
                HStack(spacing: 16) {
                    NutritionInfoView(value: "7g", nutrient: "protein", icone: "q1")
                    NutritionInfoView(value: "9g", nutrient: "fat", icone: "q2")
                    NutritionInfoView(value: "34g", nutrient: "carbo", icone: "q3")
                }
                .padding(.horizontal)

                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients:")
                        .font(.headline)
                        .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("• 1 cup (120g) all-purpose flour")
                        Text("• 1 cup (240ml) milk")
                        Text("• 2 large eggs")
                        Text("• 1 tbsp (15g) sugar")
                        Text("• A pinch of salt")
                        Text("• 2 tbsp (30g) butter (for frying)")
                        Text("• Optional toppings: powdered sugar, fresh fruit, or jam")
                    }
                    .foregroundColor(.white)
                }
                .padding()
                .background(Color("pink"))
                .cornerRadius(15)
                .padding(.horizontal)

                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions:")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    1. Prepare the Batter:
                       In a large bowl, whisk together flour, sugar, and salt.

                    2. Heat the Pan:
                       Heat a non-stick frying pan over medium heat. Add a small amount of butter and coat the pan evenly.

                    3. Cook the Pancakes:
                       Pour a ladleful of batter into the pan, tilting it to spread the batter evenly. Cook for 1-2 minutes until bubbles form on the surface and the edges lift easily.

                    4. Repeat and Serve:
                       Flip the pancake and cook the other side for another 1-2 minutes until golden brown. Repeat with the remaining batter.
                    """)
                    .foregroundColor(.white)
                }
                .padding()
                .background(Color("color1"))
                .cornerRadius(15)
                .padding(.horizontal)

               
                VStack(alignment: .leading, spacing: 10) {
                    Text("Rate this recipe")
                        .font(.headline)
                        .foregroundColor(.white)

                    HStack {
                        ForEach(1...5, id: \.self) { index in
                            Button(action: {
                                rating = index
                            }) {
                                Image(systemName: index <= rating ? "star.fill" : "star")
                                    .font(.title)
                                    .foregroundColor(index <= rating ? .yellow : .gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.horizontal)

                
               

                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Add feedback")
                        .font(.headline)
                        .foregroundColor(.white)

                    TextField("Message", text: .constant(""))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                    Button(action: {
                        showFeedbackAlert = true
                    }) {
                        Text("Add feedback")
                            .foregroundColor(.white)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("pink"))
                            .cornerRadius(10)
                    }
                }
                .padding()
                .alert(isPresented: $showFeedbackAlert) {
                    Alert(
                        title: Text("Feedback Sent"),
                        message: Text("Thank you for your feedback!"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color("backg"))
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ReviewView: View {
    let name: String
    let date: String
    let review: String
    let rating: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(name)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
                Text(date)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Text(review)
                .foregroundColor(.white)
            HStack {
                ForEach(0..<rating) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                }
            }
        }
        .padding()
        .background(Color("color1"))
        .cornerRadius(10)
    }
}

struct NutritionInfoView: View {
    let value: String
    let nutrient: String
    let icone: String

    var body: some View {
        VStack {
            Image(icone)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
            Text(nutrient)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct RecipeInfoView: View {
    let icon: String
    let text: String

    var body: some View {
        HStack {
            Image(icon)
                .foregroundColor(.gray)
            Text(text)
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    NavigationView {
        RecipeDetailsView1(
            dish: Dish(name: "German Pancakes", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "i1"),
            savedDishes: .constant([])
        )
    }
}
