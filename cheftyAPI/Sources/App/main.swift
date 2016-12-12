import Vapor

let drop = Droplet()

drop.get { request in
    //return "Hello Vapor"
    
    return try JSON(node: [
        "message": "Hello, Vapor!"
    ])
}

// the drop with a 2 level path. Get here at: http://localhost:8080/myPath/subpath
drop.get("myPath", "subpath") { request in
    //return "Hello Vapor"
    
    return try JSON(node: [
        "message": "Hello, Vapor on myPath and subpath!"
    ])
}

// the drop will take a parameter: int of beers
drop.get("beers", Int.self)


drop.run()
