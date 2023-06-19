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

    init(dto: RMCharacterDTO) {
        image = dto.image ?? ""
        name = dto.name ?? ""
        status = RMStatus(rawValue: dto.status ?? "unknown") ?? .unknown
        species = dto.species ?? ""
        type = dto.type ?? ""
        gender = dto.gender ?? ""
    }

    init(name: String, image: String, status: RMStatus, species: String, type: String, gender: String) {
        self.image = image
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
    }

    init() {
        self.image = ""
        self.name = ""
        self.status = .unknown
        self.species = ""
        self.type = ""
        self.gender = ""
    }
}
