
import SwiftUI

struct RecipeDetailsView21: View {
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
                        NutritionInfoView(value: "36g", nutrient: "protein", icone: "q1")
                        NutritionInfoView(value: "15g", nutrient: "fat", icone: "q2")
                        NutritionInfoView(value: "20g", nutrient: "carbo", icone: "q3")
                    }
                    .padding(.horizontal)

                   
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients:")
                            .font(.headline)
                            .foregroundColor(.white)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• 2 lbs (900g) beef stew meat, cubed")
                            Text("• 2 tbsp (30ml) vegetable oil")
                            Text("• 2 large onions, diced")
                            Text("• 2 garlic cloves, minced")
                            Text("• 1 tbsp (15g) tomato paste")
                            Text("• 1 cup (240ml) beef broth")
                            Text("• 1 cup (240ml) red wine (optional)")
                            Text("• 1 tsp (5g) paprika powder")
                            Text("• 1 bay leaf")
                            Text("• 1 tsp (5g) caraway seeds")
                            Text("• Salt and pepper to taste")
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
                        1. Brown the Beef:
                           Heat oil in a large pot over medium heat. Add the beef cubes and brown on all sides. Remove and set aside.

                        2. Cook the Onions:
                           In the same pot, sauté onions until golden. Add garlic and tomato paste, cooking for 1-2 minutes.

                        3. Simmer the Goulash:
                           Return the beef to the pot. Add beef broth, wine (if using), paprika, caraway seeds, and bay leaf. Season with salt and pepper. Cover and simmer on low heat for 2 hours, stirring occasionally.

                        4. Serve:
                           Remove the bay leaf. Serve hot with spaetzle, potatoes, or crusty bread.
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

