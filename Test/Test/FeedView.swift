import SwiftUI

enum FeedTab: String, CaseIterable {
    case online = "Online"
    case popular = "Popular"
    case new = "New"
    case following = "Following"
}

struct FeedView: View {
    @ObservedObject var presenter: FeedPresenter
    @State private var selectedTab: FeedTab = .online
    let badgeCount: Int = 78
    let horizontalPadding: CGFloat = 16
    let gridSpacing: CGFloat = 12
    let columns = 2
    let cardAspectRatio: CGFloat = 1.21

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top Bar
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        Text("Feed")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 24/255, green: 22/255, blue: 54/255))
                        Spacer()
                        HStack(spacing: 6) {
                            Text("\(badgeCount)")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                            ZStack {
                                Circle()
                                    .fill(Color(red: 1.0, green: 0.8, blue: 0.2))
                                    .frame(width: 22, height: 22)
                                Image(systemName: "star.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .bold))
                            }
                        }
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(Color(red: 186/255, green: 191/255, blue: 206/255))
                        .clipShape(Capsule())
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, horizontalPadding)
                    // Tabs
                    HStack(spacing: 0) {
                        ForEach(FeedTab.allCases, id: \.self) { tab in
                            Button(action: {
                                selectedTab = tab
                            }) {
                                Text(tab.rawValue)
                                    .font(.system(size: 20, weight: selectedTab == tab ? .bold : .regular))
                                    .foregroundColor(selectedTab == tab ? Color(red: 24/255, green: 22/255, blue: 54/255) : Color(red: 186/255, green: 191/255, blue: 206/255))
                                    .padding(.trailing, tab == .following ? 0 : 30)
                            }
                        }
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, horizontalPadding)
                    .padding(.bottom, 8)
                }
                // Main Area
                Group {
                    switch selectedTab {
                    case .online:
                        GeometryReader { geometry in
                            let totalSpacing = gridSpacing * CGFloat(columns - 1)
                            let totalPadding = horizontalPadding * 2
                            let cardWidth = (geometry.size.width - totalPadding - totalSpacing) / CGFloat(columns)
                            let cardHeight = cardWidth * cardAspectRatio
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: gridSpacing) {
                                    ForEach(presenter.users) { user in
                                        UserCardView(user: user) {
                                            presenter.didSelectUser(user)
                                        }
                                        .frame(width: cardWidth, height: cardHeight)
                                    }
                                }
                                .padding(.horizontal, horizontalPadding)
                                .padding(.vertical, 12)
                            }
                        }
                    case .popular:
                        Color.green.ignoresSafeArea()
                    case .new:
                        Color.blue.ignoresSafeArea()
                    case .following:
                        Color.red.ignoresSafeArea()
                    }
                }
                Spacer()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .onAppear {
                presenter.viewDidLoad()
            }
        }
    }
}

struct UserCardView: View {
    let user: FeedUser
    let onTap: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                Rectangle().fill(Color.gray.opacity(0.2)).aspectRatio(1, contentMode: .fit)
                Text(user.status == .online ? "online" : user.status == .offline ? "offline" : "recently")
                    .font(.caption2).padding(6).background(Color.black.opacity(0.6)).foregroundColor(.white).cornerRadius(8).padding(6)
            }
            HStack {
                Text(user.countryFlag)
                Text("\(user.name), \(user.age)").bold()
            }
            HStack {
                Image(systemName: "message")
                Image(systemName: "video")
                Image(systemName: "heart")
            }
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 2)
        .onTapGesture { onTap() }
    }
} 
