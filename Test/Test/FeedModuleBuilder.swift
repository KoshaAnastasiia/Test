import SwiftUI

struct FeedModuleBuilder {
    static func build() -> some View {
        let presenter = FeedPresenter()
        let interactor = FeedInteractor()
        let router = FeedRouter()
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        return FeedView(presenter: presenter, router: router)
    }
} 