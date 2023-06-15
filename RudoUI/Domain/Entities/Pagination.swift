import Foundation

struct Pagination {
    var hasNext: Bool
    var characters: [RMCharacter]?

    init(dto: PaginationDTO) {
        hasNext = dto.info?.next != nil
        characters = dto.results?.map({ RMCharacter(dto: $0) })
    }
}
