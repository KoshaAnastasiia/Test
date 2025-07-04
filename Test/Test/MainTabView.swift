import SwiftUI

enum MainTab: Int, CaseIterable {
    case live, feed, chat, profile

    var title: String {
        switch self {
        case .live: return "Live"
        case .feed: return "Feed"
        case .chat: return "Chat"
        case .profile: return "Profile"
        }
    }

    var icon: String {
        switch self {
        case .live: return "icon.life"
        case .feed: return "icon.feed"
        case .chat: return "icon.chat.tab"
        case .profile: return "icon.profile"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: MainTab = .feed

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                switch selectedTab {
                case .live:
                    Color.pink.ignoresSafeArea()
                        .transition(.opacity)
                case .feed:
                    FeedModuleBuilder.build()
                        .transition(.opacity)
                case .chat:
                    Color.indigo.ignoresSafeArea()
                        .transition(.opacity)
                case .profile:
                    Color.purple.ignoresSafeArea()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: selectedTab)
            CustomTabBar(selectedTab: $selectedTab)
        }.ignoresSafeArea(edges: .bottom)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: MainTab
    
    var body: some View {
        HStack(alignment: .top) {
            ForEach(MainTab.allCases, id: \.self) { tab in
                Spacer()
                Button(action: { selectedTab = tab }) {
                    VStack(spacing: 4) {
                        Image(tab.icon)
                            .renderingMode(.template)
                        Text(tab.title)
                            .font(.system(size: 14, weight: .medium))
                    }.foregroundColor(selectedTab == tab ? Color(red: 24/255, green: 22/255, blue: 54/255) : Color(red: 186/255, green: 191/255, blue: 206/255))
                }
                Spacer()
            }
        }
        .frame(height: 80)
        .background(
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: -2)
        )
    }
} 
