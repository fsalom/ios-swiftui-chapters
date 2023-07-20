import Foundation

struct RMCharacterDTO: Codable {
    var id: Int
    var image: String?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var isFavorite: Bool? = false

    init(entity: RMCharacter) {
        id = entity.id
        image = entity.image
        name = entity.name
        status = entity.status.rawValue
        species = entity.species
        type = entity.type
        gender = entity.gender
        isFavorite = entity.isFavorite
    }
}
