

import SwiftUI

struct RecipeDetailsView11: View {
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
                    NutritionInfoView(value: "5g", nutrient: "protein", icone: "q1")
                    NutritionInfoView(value: "15g", nutrient: "fat", icone: "q2")
                    NutritionInfoView(value: "25g", nutrient: "carbo", icone: "q3")
                }
                .padding(.horizontal)

                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients:")
                        .font(.headline)
                        .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("• 1 package (500g) puff pastry")
                        Text("• 1 cup (100g) shredded cheese (Emmental or Gouda)")
                        Text("• 1 egg yolk (for brushing)")
                        Text("• 1 tsp (5g) poppy seeds or sesame seeds")
                        Text("• Optional: herbs for garnish")
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
                       Roll out the puff pastry flat. Cut into strips about 1 inch wide.

                    2. Add Cheese:
                       Sprinkle shredded cheese evenly over half the strips. Fold the other half over and press to seal.

                    3. Cut and Twist:
                       Cut the strips into shorter lengths, twist them gently, and place them on a baking sheet lined with parchment paper.

                    4. Brush and Bake:
                       Brush with egg yolk, then sprinkle with poppy or sesame seeds. Bake in a preheated oven at 375°F (190°C) for 15-20 minutes or until golden brown.

                    5. Serve:
                       Let cool slightly before serving. Enjoy as a snack or side dish.
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
    RecipeDetailsView11(
        dish: Dish(name: "German Pancakes", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "i1"),
        savedDishes: .constant([])
    )
}
