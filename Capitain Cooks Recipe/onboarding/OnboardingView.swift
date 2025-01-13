import SwiftUI

struct OnboardingStep {
    let image: String
    let title: String
    let description: String
    let buttonText: String
}

struct OnboardingView: View {
    @State private var currentStep = 0
    @State private var start = false
    
    let onboardingSteps = [
        OnboardingStep(image: "recipe_book copy", title: "Welcome to Captain Cooks Recipe", description: "Discover a world of delicious German dishes right at your fingertips. From hearty breakfasts to indulgent desserts, we've got it all covered.", buttonText: "Next Step"),
        OnboardingStep(image: "9851110 copy", title: "Easy-to-Follow Recipes for Every Meal", description: "Our step-by-step instructions make cooking fun and simple. Each recipe is designed with clarity, ensuring great results every time.", buttonText: "Next Step"),
        OnboardingStep(image: "8519528 copy", title: "Share Your Culinary Creations", description: "Join a community of food lovers and share your experiences. Let’s inspire each other to cook and enjoy amazing German dishes!", buttonText: "Continue")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(onboardingSteps[currentStep].image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Spacer()
            
            Text(onboardingSteps[currentStep].title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("text"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
        
            Text(onboardingSteps[currentStep].description)
                .font(.body)
                .foregroundColor(Color("text2"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.top, 10)
            
            Spacer()
            
          
            HStack {
                ForEach(0..<onboardingSteps.count, id: \.self) { index in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(index == currentStep ? Color("pink") : Color.gray)
                }
            }
            .padding(.bottom, 20)
            
           
            HStack {
                if currentStep < onboardingSteps.count - 1 {
                    Button("Skip") {
                       
                        currentStep = onboardingSteps.count - 1
                        start.toggle()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                
                Button(onboardingSteps[currentStep].buttonText) {
                    if currentStep == 2 {
                          
                          start.toggle()
                      } else {
                          
                          withAnimation {
                              currentStep += 1
                            
                          }
                      }
                    
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("pink"))
                .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom , 50)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backg").scaledToFill())
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $start) {
            AccountView()
        }
    }
}

#Preview {
    OnboardingView()
}
