import SwiftUI

struct RecipeDetailsView4: View {
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
                    NutritionInfoView(value: "9g", nutrient: "protein", icone: "q1")
                    NutritionInfoView(value: "7g", nutrient: "fat", icone: "q2")
                    NutritionInfoView(value: "45g", nutrient: "carbo", icone: "q3")
                }
                .padding(.horizontal)

              
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients:")
                        .font(.headline)
                        .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("• 1 ½ cups (150g) rolled oats")
                        Text("• 1 cup (240ml) milk (dairy or plant-based)")
                        Text("• 1 cup (240ml) plain yogurt")
                        Text("• 1 apple, grated")
                        Text("• 2 tbsp (30ml) honey or maple syrup")
                        Text("• 2 tbsp (20g) chopped nuts (almonds, walnuts, or hazelnuts)")
                        Text("• 1 tbsp (10g) raisins or dried cranberries")
                        Text("• Optional toppings: fresh berries, banana slices, or a sprinkle of cinnamon")
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
                    1. Prepare the Base:
                       In a large bowl, combine rolled oats, milk, and yogurt. Stir well.

                    2. Add Ingredients:
                       Mix in grated apple, honey, nuts, and dried fruit. Cover and refrigerate overnight.

                    3. Serve:
                       In the morning, give the mixture a good stir. Adjust consistency with more milk if needed. Serve in bowls, topped with fresh fruits or cinnamon if desired.
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
        RecipeDetailsView4(
            dish: Dish(name: "German Pancakes", time: "30 min", kcal: "250 kcal", difficulty: "Easy", imageName: "i1"),
            savedDishes: .constant([])
        )
    }
}
