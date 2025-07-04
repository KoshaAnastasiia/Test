import SwiftUI

struct FeedModuleBuilder {
    func build() -> some View {
        let presenter = FeedPresenter()
        let interactor = FeedRepository()
        let router = FeedRouter()
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        return FeedView(presenter: presenter, router: router)
    }
} 
