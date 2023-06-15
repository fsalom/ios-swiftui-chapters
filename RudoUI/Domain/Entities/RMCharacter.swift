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
}
