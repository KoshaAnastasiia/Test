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
                title: "Get 599 Coins NOW And Every Week".makeAttributedForPaywallTitle(selected: "599 Coins")
            ),
            PaywallScreen(
                imageName: "payscreen.second",
                title: "Send Unlimited Messages".makeAttributedForPaywallTitle(selected: "Unlimited Messages")
            ),
            PaywallScreen(
                imageName: "payscreen.third",
                title: "Turn Off Camera & Sound".makeAttributedForPaywallTitle(selected: "Camera & Sound")
            ),
            PaywallScreen(
                imageName: "payscreen.forth",
                title: "Mark Your Profile With VIP Status".makeAttributedForPaywallTitle(selected: "VIP Status")
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
                    }
                    .tag(idx)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            HStack(spacing: 10) {
                ForEach(0..<screens.count, id: \.self) { idx in
                    Circle()
                        .fill(idx == selectedIndex ? Color.rgba(157, 153, 255, 1) : Color.rgba(175, 182, 200, 1))
                        .frame(width: 8, height: 8)
                }
            }
            Spacer()
            VStack(spacing: 0) {
                Text("Subscribe for $0.99 weekly")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 6)
                    .padding(.top, 60)
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
                            .underline()
                            .foregroundStyle(Color.white)
                    }
                    Spacer()
                    Button(action: {}) {
                        Text("Privacy & Policy")
                            .font(.system(size: 12, weight: .light))
                            .underline()
                            .foregroundStyle(Color.white)
                    }
                }.padding(.bottom, 90)
            }.padding(.horizontal, 16)
                .background(
                    GeometryReader { geometry in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: height))
                            path.addLine(to: CGPoint(x: width, y: height))
                            path.addLine(to: CGPoint(x: width, y: 0))
                            path.addQuadCurve(to: CGPoint(x: 0, y: 0), control: CGPoint(x: width / 2, y: height * 0.2))
                            path.addLine(to: CGPoint(x: 0, y: height))
                        }
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.rgba(157, 153, 255, 1), Color.blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                    }
                )
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden(true)
    }
}
