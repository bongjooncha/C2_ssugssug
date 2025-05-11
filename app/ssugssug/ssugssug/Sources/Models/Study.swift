struct Study {
    let name: String
    let type: String
    let time: Int16
    let goalGrouth: Int8

    var grouth: Int8
    var Contents: [Content]
} 

struct Content {
    let order: Int8

    var goal: String
    var conclusion: String
}
