import Foundation

struct Pagination {
    var hasNextPage: Bool
    var characters: [RMCharacter]

    init(dto: PaginationDTO) {
        hasNextPage = dto.info?.next != nil
        characters = dto.results?.map({ RMCharacter(dto: $0) }) ?? []
    }
}
