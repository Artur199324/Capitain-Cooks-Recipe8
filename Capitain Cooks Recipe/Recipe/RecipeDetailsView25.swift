

import SwiftUI

struct RecipeDetailsView25: View {
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
                       NutritionInfoView(value: "25g", nutrient: "protein", icone: "q1")
                       NutritionInfoView(value: "19g", nutrient: "fat", icone: "q2")
                       NutritionInfoView(value: "19g", nutrient: "carbo", icone: "q3")
                   }
                   .padding(.horizontal)

               
                   VStack(alignment: .leading, spacing: 10) {
                       Text("Ingredients:")
                           .font(.headline)
                           .foregroundColor(.white)

                       VStack(alignment: .leading, spacing: 8) {
                           Text("• 1 lb (450g) ground beef or pork")
                           Text("• 1 egg")
                           Text("• ½ cup (50g) breadcrumbs")
                           Text("• 1 small onion, finely chopped")
                           Text("• 1 tsp mustard")
                           Text("• Salt and pepper to taste")
                           Text("• 2 tbsp (30g) butter")
                           Text("• 2 tbsp (30g) flour")
                           Text("• 2 cups (480ml) beef broth")
                           Text("• ½ cup (120ml) heavy cream")
                           Text("• 2 tbsp (30g) capers")
                           Text("• 1 tbsp (15ml) lemon juice")
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
                       1. Prepare the Meatballs:
                          In a bowl, combine ground meat, egg, breadcrumbs, onion, mustard, salt, and pepper. Mix well and form into small meatballs.

                       2. Cook the Meatballs:
                          In a pot of simmering salted water, gently cook the meatballs for 10–15 minutes. Remove and set aside.

                       3. Make the Sauce:
                          In a saucepan, melt butter and stir in flour to form a roux. Gradually add beef broth, stirring constantly until smooth. Stir in heavy cream, capers, and lemon juice. Simmer for 5 minutes.

                       4. Combine and Serve:
                          Add the meatballs to the sauce and simmer for another 5 minutes. Serve with boiled potatoes or rice.
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
