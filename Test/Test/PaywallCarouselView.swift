import SwiftUI

struct PaywallScreen: Identifiable {
    let id = UUID()
    let imageName: String
    let title: AttributedString
}

struct PaywallCarouselView: View {
    let screens: [PaywallScreen] = [
        PaywallScreen(
            imageName: "payscreen.first",
            title: try! AttributedString(markdown: "Get **599 Coins** NOW And Every Week")
        ),
        PaywallScreen(
            imageName: "payscreen.second",
            title: try! AttributedString(markdown: "Send **Unlimited Messages**")
        ),
        PaywallScreen(
            imageName: "payscreen.third",
            title: try! AttributedString(markdown: "Turn Off **Camera & Sound**")
        ),
        PaywallScreen(
            imageName: "payscreen.forth",
            title: try! AttributedString(markdown: "Mark Your Profile With **VIP Status**")
        )
    ]

    @Environment(\.presentationMode) var presentationMode
    @State private var selectedIndex: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.rgba(175, 182, 200, 1))
                }
                Spacer()
                Button(action: {}) {
                    Text("Restore")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.rgba(175, 182, 200, 1))
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 10)
            .padding(.horizontal, 16)
            TabView(selection: $selectedIndex) {
                ForEach(Array(screens.enumerated()), id: \.element.id) { idx, screen in
                    VStack(spacing: 0) {
                        Text(screen.title)
                            .font(.system(size: 18, weight: .heavy))
                            .multilineTextAlignment(.center)
                            .frame(width: 331, height: 58)
                        Image(screen.imageName)
                            .padding(.bottom, 50)
                    }
                    .tag(idx)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            Spacer()
            VStack(spacing: 0) {
                Text("Subscribe for $0.99 weekly")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 6)
                    .padding(.top, 30)
                Text("Plan automatically renews. Cancel anytime.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 15)
                Button(action: {}) {
                    Text("Subscribe")
                        .font(.system(size: 16, weight: .heavy))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.rgba(141, 234, 228, 1), Color.rgba(93, 189, 193, 1)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(24)
                        .foregroundStyle(Color.white)
                }
                .padding(.bottom, 13)
                HStack {
                    Button(action: {}) {
                        Text("Terms of Use")
                            .font(.system(size: 12, weight: .light))
                            .foregroundStyle(Color.white)
                    }
                    Spacer()
                    Button(action: {}) {
                        Text("Privacy & Policy")
                            .font(.system(size: 12, weight: .light))
                            .foregroundStyle(Color.white)
                    }
                }.padding(.bottom, 60)
            }.padding(.horizontal, 16)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
            )
        }
        .ignoresSafeArea(edges: .bottom)
//        .background(Color.green)
        .navigationBarBackButtonHidden(true)
    }
}
