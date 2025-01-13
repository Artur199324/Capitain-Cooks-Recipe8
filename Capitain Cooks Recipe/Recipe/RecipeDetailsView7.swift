
import SwiftUI

struct RecipeDetailsView7: View {
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
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
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
                    NutritionInfoView(value: "8g", nutrient: "protein", icone: "q1")
                    NutritionInfoView(value: "10g", nutrient: "fat", icone: "q2")
                    NutritionInfoView(value: "47g", nutrient: "carbo", icone: "q3")
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
                        Text("• 2 tbsp (30g) sugar")
                        Text("• 1 tsp (5ml) vanilla extract")
                        Text("• A pinch of salt")
                        Text("• 1 large apple, thinly sliced")
                        Text("• 2 tbsp (30g) butter (for frying)")
                        Text("• Optional: powdered sugar or cinnamon for topping")
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
                       In a bowl, whisk together flour, sugar, salt, milk, eggs, and vanilla until smooth. Let the batter rest for 10 minutes.

                    2. Cook the Pancakes:
                       Heat a non-stick skillet over medium heat. Melt a small amount of butter. Pour a ladleful of batter into the pan, spreading it evenly. Arrange a few apple slices on top.

                    3. Flip and Cook:
                       Cook for 2–3 minutes until bubbles form and edges lift easily. Flip the pancake and cook for another 2–3 minutes.

                    4. Serve:
                       Sprinkle with powdered sugar or cinnamon before serving.
                    """)
                    .foregroundColor(.white)
                }
                .padding()
                .background(Color("color1"))
                .cornerRadius(15)
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



#Preview {
    NavigationView {
        RecipeDetailsView7(
            dish: Dish(name: "German Pancakes", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "i1"),
            savedDishes: .constant([])
        )
    }
}
