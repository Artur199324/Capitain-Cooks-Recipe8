

import SwiftUI

struct RecipeDetailsView32: View {
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
                       NutritionInfoView(value: "12g", nutrient: "protein", icone: "q1")
                       NutritionInfoView(value: "10g", nutrient: "fat", icone: "q2")
                       NutritionInfoView(value: "45g", nutrient: "carbo", icone: "q3")
                   }
                   .padding(.horizontal)

                  
                   VStack(alignment: .leading, spacing: 10) {
                       Text("Ingredients:")
                           .font(.headline)
                           .foregroundColor(.white)

                       VStack(alignment: .leading, spacing: 8) {
                           Text("• 2 cups (240g) all-purpose flour")
                           Text("• 4 large eggs")
                           Text("• ½ cup (120ml) milk")
                           Text("• 1 tsp (5g) salt")
                           Text("• 1 tbsp (15g) butter")
                           Text("• 1 tbsp (15g) chopped parsley (optional)")
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
                       1. Make the Dough:
                          In a large bowl, combine flour, eggs, milk, and salt. Mix until smooth and thick, similar to pancake batter.

                       2. Cook the Spätzle:
                          Bring a large pot of salted water to a boil. Using a spatula and colander, press the dough into the boiling water. Cook the spätzle in batches for about 2–3 minutes, or until they float to the surface.

                       3. Sauté the Spätzle:
                          Drain the cooked spätzle and sauté them in melted butter in a large skillet for 5 minutes, until slightly crispy.

                       4. Serve:
                          Garnish with parsley and serve as a side dish with meats or gravy.
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
