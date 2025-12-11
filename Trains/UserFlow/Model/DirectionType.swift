//  DirectionType.swift

// Тип направления
enum DirectionType: String, Sendable, Decodable {
    case from = "Откуда" 
    case to = "Куда"
    case none
}
