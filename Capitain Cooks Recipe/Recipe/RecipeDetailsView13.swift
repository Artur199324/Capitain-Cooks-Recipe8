

import SwiftUI

struct RecipeDetailsView13: View {
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
                        NutritionInfoView(value: "10g", nutrient: "fat", icone: "q2")
                        NutritionInfoView(value: "4g", nutrient: "carbo", icone: "q3")
                    }
                    .padding(.horizontal)

                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients:")
                            .font(.headline)
                            .foregroundColor(.white)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• 1 cup (120g) Camembert cheese")
                            Text("• 2 tbsp (30g) cream cheese")
                            Text("• 1 tbsp (15g) butter, softened")
                            Text("• 1 tbsp onion, finely chopped")
                            Text("• 1 tsp (5g) paprika powder")
                            Text("• 1 tbsp (15ml) beer (optional)")
                            Text("• A pinch of salt and pepper")
                            Text("• Chives for garnish")
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
                        1. Prepare the Cheese Mixture:
                           Mash the Camembert with a fork. Mix in cream cheese, butter, chopped onion, and paprika.

                        2. Add Flavor:
                           Stir in beer (if using) and season with salt and pepper. Mix until smooth.

                        3. Serve:
                           Garnish with chives. Serve with pretzels or rye bread as a snack.
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
