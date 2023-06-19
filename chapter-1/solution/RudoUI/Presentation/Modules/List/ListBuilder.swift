import Foundation

class ListBuilder {
    func build() -> ListView<ListViewModel> {
        let viewModel = ListViewModel()
        let view = ListView(viewModel: viewModel)
        return view
    }
}
