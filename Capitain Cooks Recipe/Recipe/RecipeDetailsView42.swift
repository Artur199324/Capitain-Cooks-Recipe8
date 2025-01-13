
import SwiftUI

struct RecipeDetailsView42: View {
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
                        NutritionInfoView(value: "6g", nutrient: "protein", icone: "q1")
                        NutritionInfoView(value: "20g", nutrient: "fat", icone: "q2")
                        NutritionInfoView(value: "45g", nutrient: "carbo", icone: "q3")
                    }
                    .padding(.horizontal)

                  
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients:")
                            .font(.headline)
                            .foregroundColor(.white)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("For the Dough:")
                            Text("• 3 cups (375g) all-purpose flour")
                            Text("• 1/2 cup (100g) sugar")
                            Text("• 1/2 tsp (2g) salt")
                            Text("• 1 packet (7g) dry yeast")
                            Text("• 3/4 cup (180ml) milk, warm")
                            Text("• 1/4 cup (60g) butter, melted")
                            Text("• 1 egg")
                            Text("For the Topping:")
                            Text("• 1/4 cup (50g) butter")
                            Text("• 1/4 cup (50g) sugar")
                            Text("• 2 tbsp (30ml) honey")
                            Text("• 1/2 cup (50g) sliced almonds")
                            Text("For the Filling:")
                            Text("• 2 cups (500ml) milk")
                            Text("• 1/4 cup (50g) sugar")
                            Text("• 1 packet (37g) vanilla pudding mix")
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
                           Mix all ingredients and let rise for 1 hour. Roll out the dough in a cake pan, let rise again, and bake for 20 minutes at 350°F (175°C).

                        2. Prepare the Topping:
                           Heat butter, sugar, and honey, then add almonds. Spread on the cake and bake for 10 more minutes.

                        3. Prepare the Filling:
                           Whisk milk, sugar, and pudding mix. Let cool, then slice the cake in half and fill with the cream.
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
