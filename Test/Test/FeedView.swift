import SwiftUI

enum FeedTab: String, CaseIterable {
    case online = "Online"
    case popular = "Popular"
    case new = "New"
    case following = "Following"
}

struct FeedView: View {
    @ObservedObject var presenter: FeedPresenter
    @ObservedObject var router: FeedRouter
    @State private var selectedTab: FeedTab = .online
    let badgeCount: Int = 78
    let horizontalPadding: CGFloat = 12
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
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(Color.rgba(25, 20, 57, 1))
                        Spacer()
                        HStack(spacing: 6) {
                            Text("\(badgeCount)")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 16, weight: .semibold))
                            ZStack {
                                Circle()
                                    .fill(Color(red: 1.0, green: 0.8, blue: 0.2))
                                    .frame(width: 22, height: 22)
                                Image(systemName: "star.fill")
                                    .foregroundStyle(Color.white)
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
                                    .foregroundStyle(selectedTab == tab ? Color.rgba(25, 20, 57, 1) : Color.rgba(175, 182, 200, 1))
                                    .padding(.trailing, tab == .following ? 0 : 33)
                            }
                        }
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, horizontalPadding)
                    .padding(.bottom, 8)
                }
                // Main Area
                ZStack {
                    switch selectedTab {
                    case .online:
                        GeometryReader { geometry in
                            let totalSpacing = gridSpacing * CGFloat(columns - 1)
                            let totalPadding = horizontalPadding * 2
                            let cardWidth = (geometry.size.width - totalPadding - totalSpacing) / CGFloat(columns)
                            let cardHeight = cardWidth * cardAspectRatio
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: gridSpacing) {
                                    ForEach(Array(presenter.users.enumerated()), id: \.element.id) { index, user in
                                        UserCardView(user: user, cardWidth: cardWidth) {
                                            presenter.didSelectUser(user, at: index)
                                        }
                                        .frame(width: cardWidth, height: cardHeight)
                                    }
                                }
                                .padding(.horizontal, horizontalPadding)
                                .padding(.vertical, 12)
                                .padding(.bottom, 50)
                            }
                        }
                        .transition(.opacity)
                    case .popular:
                        Color.green.ignoresSafeArea()
                            .transition(.opacity)
                    case .new:
                        Color.indigo.ignoresSafeArea()
                            .transition(.opacity)
                    case .following:
                        Color.purple.ignoresSafeArea()
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: selectedTab)
                Spacer()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .onAppear {
                presenter.viewDidLoad()
            }
            .sheet(isPresented: $router.isShowedPaywallSheet) {
                PaywallCarouselView()
            }
        }
    }
}

struct UserCardView: View {
    let user: FeedUser
    let cardWidth: CGFloat
    let onTap: () -> Void
    var body: some View {
        AsyncImage(url: URL(string: user.imageUrl)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: cardWidth + 40)
                .cornerRadius(16)
                .shadow(radius: 2)
        } placeholder: {
            Rectangle().fill(Color.gray.opacity(0.2))
        }
        .overlay {
            VStack(alignment: .leading) {
                HStack {
                    Circle().fill(user.status.color)
                        .frame(width: 7)
                    Text(user.status.rawValue)
                        .font(.system(size: 12, weight: .light))
                        .foregroundStyle(Color.white)
                }
                .padding(6)
                .background(Color.black.opacity(0.6))
                .cornerRadius(55)
                .padding(9)
                Spacer()
                HStack {
                    Spacer()
                    Text(user.countryFlag)
                        .frame(width: 30, height: 20)
                        .font(.system(size: 40, weight: .bold))
                        .clipShape(.circle)
                    Text("\(user.name), \(user.age)")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.white)
                        .padding(.trailing, 7)
                    Spacer()
                }
                HStack(spacing: 22) {
                    Spacer()
                    Button(action: { print("tap on \(user.name) chat") }) {
                        Image("icon.chat")
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: { print("tap on \(user.name) video") }) {
                        Image("icon.video")
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: { print("tap on \(user.name) favorite") }) {
                        Image("icon.favorite")
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }.padding(.bottom, 9)
            }
        }
        .onTapGesture { onTap() }
    }
}
