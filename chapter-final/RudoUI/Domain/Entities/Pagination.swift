import Foundation

struct Pagination {
    var hasNextPage: Bool
    var characters: [Character]

    init(dto: PaginationDTO) {
        hasNextPage = dto.info?.next != nil
        characters = dto.results?.map({ Character(dto: $0) }) ?? []
    }
}
