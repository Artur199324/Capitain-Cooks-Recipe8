import SwiftUI

struct RecipeDetailsView2: View {
    let dish: Dish
    @State private var rating: Int = 0
  
    @State private var showFeedbackAlert = false
    @State private var isSaved = false
    @Binding var savedDishes: [Dish]
    @State private var showSaveMessage = false
    @Environment(\.dismiss) var dismiss
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
                    NutritionInfoView(value: "6g", nutrient: "protein", icone: "q1")
                    NutritionInfoView(value: "2g", nutrient: "fat", icone: "q2")
                    NutritionInfoView(value: "42g", nutrient: "carbo", icone: "q3")
                }
                .padding(.horizontal)

              
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients:")
                        .font(.headline)
                        .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("• 4 cups (500g) all-purpose flour")
                        Text("• 1 tsp (5g) salt")
                        Text("• 1 tbsp (10g) sugar")
                        Text("• 2 ½ tsp (7g) active dry yeast")
                        Text("• 1 ¼ cups (300ml) warm water")
                        Text("• 2 tbsp (30g) unsalted butter, melted")
                        Text("• ½ cup (120g) baking soda")
                        Text("• 9 cups (2L) water (for boiling)")
                        Text("• Coarse salt for topping")
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
                    1. Prepare the Dough:
                       Mix warm water and yeast, let sit for 5 minutes. Combine flour, salt, sugar, yeast mixture, and melted butter. Knead and let rise.

                    2. Shape the Pretzels:
                       Divide dough, shape into pretzels.

                    3. Boil the Pretzels:
                       Boil pretzels in baking soda water for 20-30 seconds.

                    4. Bake:
                       Bake at 425°F (220°C) for 12-15 minutes until golden.
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
#Preview {
    NavigationView {
        RecipeDetailsView2(
            dish: Dish(name: "German Pancakes", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "i1"),
            savedDishes: .constant([])
        )
    }
}
