

import SwiftUI

struct RecipeDetailsView24: View {
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
                        NutritionInfoView(value: "45g", nutrient: "protein", icone: "q1")
                        NutritionInfoView(value: "22g", nutrient: "fat", icone: "q2")
                        NutritionInfoView(value: "11g", nutrient: "carbo", icone: "q3")
                    }
                    .padding(.horizontal)

                 
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients:")
                            .font(.headline)
                            .foregroundColor(.white)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• 3 lbs (1.5kg) pork shoulder or pork belly (with skin)")
                            Text("• 2 tbsp (30ml) vegetable oil")
                            Text("• 1 large onion, diced")
                            Text("• 2 carrots, diced")
                            Text("• 2 celery stalks, diced")
                            Text("• 4 garlic cloves, minced")
                            Text("• 1 cup (240ml) beer")
                            Text("• 1 cup (240ml) chicken broth")
                            Text("• 1 tsp (5g) caraway seeds")
                            Text("• 1 tsp (5g) salt")
                            Text("• 1 tsp (5g) black pepper")
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
                        1. Prepare the Pork:
                           Preheat the oven to 350°F (175°C). Score the skin of the pork in a crosshatch pattern. Rub with salt, pepper, and caraway seeds.

                        2. Sear the Pork:
                           Heat oil in a large ovenproof pot. Sear the pork on all sides until browned. Remove and set aside.

                        3. Cook the Vegetables:
                           In the same pot, sauté onions, carrots, celery, and garlic until softened.

                        4. Roast the Pork:
                           Return the pork to the pot. Pour in the beer and chicken broth.

                           Cover and roast in the oven for 2.5 hours.

                        5. Finish the Skin:
                           Increase oven temperature to 425°F (220°C). Uncover the pot and roast for another 20–30 minutes to crisp up the skin.

                        6. Serve:
                           Slice the pork and serve with the vegetables and pan juices. Pair with potato dumplings and red cabbage.
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
