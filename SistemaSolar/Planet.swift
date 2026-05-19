import SwiftUI

struct Planet: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String
    let type: String
    let distance: String
    let diameter: String
    let moons: Int
    let description: String
    let color1: Color
    let color2: Color
    let funFact: String
    let travelTime: String
}

let planets: [Planet] = [
    Planet(name: "Mercurio",
           imageName: "planet_mercury",
           type: "Planeta Rocoso",
           distance: "77.3 M km",
           diameter: "4,879 km",
           moons: 0,
           description: "El planeta más pequeño del sistema solar. No tiene atmósfera por lo que sus temperaturas van de -180°C a 430°C.",
           color1: Color(red: 0.55, green: 0.45, blue: 0.33),
           color2: Color(red: 0.35, green: 0.28, blue: 0.20),
           funFact: "Un año en Mercurio dura solo 88 días terrestres.",
           travelTime: "147 días"),

    Planet(name: "Venus",
           imageName: "planet_venus",
           type: "Planeta Rocoso",
           distance: "261 M km",
           diameter: "12,104 km",
           moons: 0,
           description: "El planeta más caliente del sistema solar con 465°C constantes gracias a su efecto invernadero.",
           color1: Color(red: 0.91, green: 0.77, blue: 0.43),
           color2: Color(red: 0.75, green: 0.55, blue: 0.22),
           funFact: "Venus gira al revés comparado con los demás planetas.",
           travelTime: "97 días"),

    Planet(name: "Tierra",
           imageName: "planet_earth",
           type: "Planeta Rocoso",
           distance: "0 km",
           diameter: "12,742 km",
           moons: 1,
           description: "Nuestro hogar. El único planeta conocido con vida y agua líquida en su superficie.",
           color1: Color(red: 0.13, green: 0.59, blue: 0.65),
           color2: Color(red: 0.09, green: 0.38, blue: 0.27),
           funFact: "El 71% de la superficie terrestre está cubierta de agua.",
           travelTime: "¡Estás aquí!"),

    Planet(name: "Marte",
           imageName: "planet_mars",
           type: "Planeta Rocoso",
           distance: "225 M km",
           diameter: "6,779 km",
           moons: 2,
           description: "El planeta rojo. Tiene el volcán más alto del sistema solar: Olympus Mons con 22 km.",
           color1: Color(red: 0.76, green: 0.27, blue: 0.06),
           color2: Color(red: 0.50, green: 0.15, blue: 0.03),
           funFact: "Un día en Marte dura 24 horas y 37 minutos.",
           travelTime: "7 meses"),

    Planet(name: "Júpiter",
           imageName: "planet_jupiter",
           type: "Gigante Gaseoso",
           distance: "778 M km",
           diameter: "139,820 km",
           moons: 95,
           description: "El planeta más grande del sistema solar. Su Gran Mancha Roja es una tormenta de más de 350 años.",
           color1: Color(red: 0.78, green: 0.55, blue: 0.23),
           color2: Color(red: 0.60, green: 0.38, blue: 0.18),
           funFact: "Júpiter tiene 95 lunas conocidas.",
           travelTime: "2 años"),

    Planet(name: "Saturno",
           imageName: "planet_saturn",
           type: "Gigante Gaseoso",
           distance: "1,400 M km",
           diameter: "116,460 km",
           moons: 146,
           description: "Famoso por sus anillos. Es tan poco denso que flotaría en el agua.",
           color1: Color(red: 0.89, green: 0.78, blue: 0.50),
           color2: Color(red: 0.70, green: 0.58, blue: 0.30),
           funFact: "Los anillos de Saturno se extienden 270,000 km.",
           travelTime: "3.5 años"),

    Planet(name: "Urano",
           imageName: "planet_uranus",
           type: "Gigante de Hielo",
           distance: "2,700 M km",
           diameter: "50,724 km",
           moons: 28,
           description: "Gira de costado con una inclinación de 98°. Sus temperaturas bajan hasta -224°C.",
           color1: Color(red: 0.49, green: 0.91, blue: 0.91),
           color2: Color(red: 0.27, green: 0.65, blue: 0.72),
           funFact: "Fue el primer planeta descubierto con telescopio en 1781.",
           travelTime: "9 años"),

    Planet(name: "Neptuno",
           imageName: "planet_neptune",
           type: "Gigante de Hielo",
           distance: "4,300 M km",
           diameter: "49,244 km",
           moons: 16,
           description: "El planeta más lejano del sistema solar con vientos de 2,100 km/h.",
           color1: Color(red: 0.25, green: 0.33, blue: 0.73),
           color2: Color(red: 0.12, green: 0.18, blue: 0.50),
           funFact: "Un año en Neptuno dura 165 años terrestres.",
           travelTime: "12 años")
]
