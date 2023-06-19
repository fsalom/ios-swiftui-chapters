import Foundation

struct RMCharacter: Identifiable {
    enum RMStatus: String {
        case Dead
        case Alive
        case unknown
    }

    var id: String = UUID().uuidString
    var image: String
    var name: String
    var status: RMStatus
    var species: String
    var type: String
    var gender: String
}
