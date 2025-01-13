

import SwiftUI

struct RecipeDetailsView15: View {
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
                    NutritionInfoView(value: "3g", nutrient: "protein", icone: "q1")
                    NutritionInfoView(value: "5g", nutrient: "fat", icone: "q2")
                    NutritionInfoView(value: "21g", nutrient: "carbo", icone: "q3")
                }
                .padding(.horizontal)

               
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients:")
                        .font(.headline)
                        .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("• 1 package (500g) puff pastry")
                        Text("• 2 medium apples, peeled and finely chopped")
                        Text("• 2 tbsp (30g) sugar")
                        Text("• 1 tsp (5g) cinnamon")
                        Text("• 1 tbsp (15g) breadcrumbs")
                        Text("• 1 tbsp (15g) butter, melted")
                        Text("• 1 egg (for brushing)")
                        Text("• Powdered sugar for garnish")
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
                    1. Prepare the Filling:
                       In a bowl, mix chopped apples with sugar, cinnamon, and breadcrumbs.

                    2. Assemble the Bites:
                       Roll out the puff pastry and cut into 12 squares. Place a small spoonful of the apple mix in the center of each square. Fold the pastry edges over the filling, pinching them to seal.

                    3. Brush and Bake:
                       Place the bites on a parchment-lined baking sheet. Brush with melted butter and egg yolk. Bake at 375°F (190°C) for 20–25 minutes until golden brown.

                    4. Serve:
                       Dust with powdered sugar before serving.
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

