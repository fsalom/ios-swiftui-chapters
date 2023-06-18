import SwiftUI

struct ListView<VM>: View where VM: ListViewModelProtocol {
    @ObservedObject var viewModel: VM

    var body: some View {
        Text("Fix this")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListBuilder().build()
    }
}
