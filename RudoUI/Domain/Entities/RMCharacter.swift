import Foundation

struct RMCharacter {
    var image: String
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String

    init(dto: RMCharacterDTO) {
        image = dto.image ?? ""
        name = dto.name ?? ""
        status = dto.status ?? ""
        species = dto.species ?? ""
        type = dto.type ?? ""
        gender = dto.gender ?? ""
    }

    init(name: String, image: String, status: String, species: String, type: String, gender: String) {
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
        self.status = ""
        self.species = ""
        self.type = ""
        self.gender = ""
    }
}
