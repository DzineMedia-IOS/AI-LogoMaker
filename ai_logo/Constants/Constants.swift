//
//  Constants.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import Foundation

import UIKit

enum Storyboard: String {
    case main = "Main"
    case creation = "Creation"
//    case profile = "Profile"
    case projects = "Projects"
    case aiLogo = "AiLogo"
    case settings = "Settings"
    case premium = "Premium"
    
    

    /// Instantiate a view controller from the storyboard.
    /// - Parameters:
    ///   - viewController: The type of the view controller to instantiate.
    ///   - bundle: The bundle containing the storyboard file. Defaults to `nil`.
    func instantiate<T: UIViewController>(_ viewController: T.Type, bundle: Bundle? = nil) -> T {
        let storyboard = UIStoryboard(name: self.rawValue, bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not instantiate view controller \(T.self) from storyboard \(self.rawValue).")
        }
        return viewController
    }
}
let hapticFeedbackKey = "hapticFeedbackEnabled"

let styleArray: [Style] = [
    Style(img: "no_style", title: "No Style"),
    Style(img: "abstract", title: "Abstract"),
    Style(img: "art_deco", title: "Art Deco"),
    Style(img: "classic", title: "Classic"),
    Style(img: "corporate", title: "Corporate"),
    Style(img: "elegant", title: "Elegant"),
    Style(img: "furistic", title: "Futuristic"),
    Style(img: "minimalist", title: "Minimalist"),
    Style(img: "geomatric", title: "Geometric"),
    Style(img: "grung", title: "Grunge"),
    Style(img: "hand_drawn", title: "Hand Drawn"),
    Style(img: "mascot", title: "Mascot"),
    Style(img: "minimal", title: "Minimal"),
    Style(img: "modren", title: "Modern"),
    Style(img: "mongram", title: "Monogram"),
    Style(img: "nature", title: "Nature"),
    Style(img: "vintage", title: "Vintage"),
]

// 32 Discover ideas
let discoverArr: [Style] = [
    Style(img: "discover_1", title: "A young Caucasian woman with short blonde hair wearing a virtual reality headset in a surreal forest landscape with pink clouds"),
    Style(img: "discover_2", title: "A young African American man with curly black hair and glasses , making a surprised facial expression with his mouth open and eyes wide , against a yellow and red comic book style background with the word \"WOW!\" in the center"),
    Style(img: "discover_3", title: "A young, pale-skinned Asian girl with long dark hair wearing a light-colored coat and a lavender scarf in a snowy, winter landscape with bare trees"),
    Style(img: "discover_4", title: "A smiling 35-year-old Caucasian man with short dark hair and a beard , wearing a green button-up shirt , in a lush green outdoor setting with flowers in the background"),
    Style(img: "discover_5", title: "A middle-aged Caucasian woman with short brown hair in a simple black and white logo design"),
    Style(img: "discover_6", title: "Text graphic with the word \"Africa\" in a stylized script font against a bright yellow background"),
    Style(img: "discover_7", title: " A colorful, abstract portrait of a person with vibrant, rainbow-colored hair and facial features against a gradient background of pink, orange, and yellow"),
    Style(img: "discover_8", title: "A black and white sketch of a bouquet of flowers , including large blooming flowers and smaller buds on long stems against a plain background"),
    Style(img: "discover_9", title: "A large pink daisy flower with yellow center on a blue stem against a colorful pink and blue background"),
    Style(img: "discover_10", title: "A minimalist logo design featuring a stylized letter 'r' in white against a purple circular background"),
    Style(img: "discover_11", title: "A young, pale-skinned woman with long, flowing blonde hair wearing a teal blue dress standing in a snowy, icy environment with swirling mist or fog around her"),
    Style(img: "discover_12", title: "A modern, minimalist house with a flat roof, large windows, and a patio surrounded by small trees and shrubs on a grassy lawn"),
    Style(img: "discover_13", title: "A lone figure walking down a path in an autumn forest, with warm-toned leaves and branches overhead creating a tunnel-like effect"),
    Style(img: "discover_14", title: "Dove icon with abstract geometric wings , set against a solid background"),
    Style(img: "discover_15", title: "A young Caucasian woman with long blonde hair wearing a futuristic helmet with glowing neon lights , set against a colorful, abstract background"),
    Style(img: "discover_16", title: "A large, fierce-looking orange dragon with horns and spikes emerging from an egg-shaped nest on a grassy field"),
    Style(img: "discover_17", title: "A black and white line drawing of a woman's face with leaves and branches growing out of her head, creating a nature-inspired headdress or crown"),
    Style(img: "discover_18", title: "A lush, colorful garden path leading to a serene ocean view with a blue sky and fluffy clouds"),
    Style(img: "discover_19", title: "A middle-aged Caucasian man with a beard wearing headphones , a gray hoodie , and blue jeans standing against an orange background"),
    Style(img: "discover_20", title: "A young Caucasian woman with long blonde hair wearing a futuristic cyberpunk outfit , including a metallic headpiece and glowing neon lights . She has a serious expression on her face and appears to be in a dark, neon-lit environment"),
    Style(img: "discover_21", title: "A young Caucasian woman with long, wavy red hair wearing a flower crown and feathered wings , surrounded by glowing embers and sparks against a dark, moody background"),
    Style(img: "discover_22", title: "A young Japanese girl with short black hair and pink flower clips , wearing a blue kimono , standing in front of a cherry blossom tree with a pink sky in the background"),
    Style(img: "discover_23", title: "A young woman with pale skin , dark hair , and striking blue eyes . She has an intricate, futuristic headpiece made of glowing blue and orange wires that appear to be connected to her head. The background is dark with blurred city lights , creating a moody, cyberpunk-inspired atmosphere"),
    Style(img: "discover_24", title: "A close up of a person with a tattoo on their arm, highly detailed and colored, oriental tattoos, arm tattoos, tattoo on upper arm, very detailed and colorful, arm tattoo, photograph of a sleeve tattoo, traditional tattoo, inked and colored, neotraditional tattoos, highly detailed and realistic, detailed and realistic, beautiful realistic upper body, colourful!! highly detailed"),
    Style(img: "discover_25", title: "A young Caucasian woman with long brown hair surrounded by vibrant flowers and foliage , her face partially obscured by the lush greenery"),
    Style(img: "discover_26", title: "A young Latina girl with dark hair and a straw hat , wearing a white shawl , standing in a field of yellow flowers"),
    Style(img: "discover_27", title: "A young woman with short, spiky white hair wearing round glasses and a gray jacket against a colorful abstract background"),
    Style(img: "discover_28", title: "Close-up of a muscular arm showcasing an intricate black and gray tattoo. The design features Egyptian motifs, including a detailed depiction of a pharaoh's face surrounded by hieroglyphs and various symbols. The tattoo covers the entire forearm and part of the upper arm, highlighting elaborate patterns and textures against the skin. The person is wearing a sleeveless black shirt, emphasizing the tattoo's prominence."),
    Style(img: "discover_29", title: "A young girl with long brown hair wearing a blue floral hat , holding a small brown puppy dog , surrounded by sunflowers and blue flowers"),
    Style(img: "discover_30", title: "A colorful and vibrant close-up portrait of an owl with large, piercing eyes. The owl has a mix of blue, orange, and red feathers, creating a striking and abstract appearance. The background features abstract floral elements in warm, vibrant colors , adding to the dreamlike and surreal atmosphere"),
    Style(img: "discover_31", title: "A fierce tiger head logo with the text \"FURY TIGER\" on a orange background"),
    Style(img: "discover_32", title: "A low-poly gray parrot with a sharp beak against a dark background"),
    Style(img: "discover_33", title: "A young Caucasian woman with long, wavy red hair surrounded by abstract floral elements and warm, vibrant colors"),
    Style(img: "discover_34", title: "A glass bottle of perfume surrounded by colorful flowers and abstract splashes of paint in vibrant shades of pink against a dark background"),
    Style(img: "discover_35", title: "A detailed tattoo on a forearm featuring a grinning clown with blue and red face paint, styled like a jester. Above the clown, the text reads HAVE YOU EVER DANCED WITH DEVIL, and below it, IN THE FREE MOONLIGHT? The background includes a large, pale moon, enhancing the eerie ambiance of the design. The arm is positioned against a textured white brick wall."),
    Style(img: "discover_36", title: "A young Asian woman with long dark hair, wearing a black coat , looking directly at the camera with a serious expression"),
]

let startPrompt = "A black and white sketch of a bouquet of flowers , including large blooming flowers and smaller buds on long stems against a plain background"


let logoPrompt = "a modern text-based logo for Dzine Media, featuring sleek typography with a tech-inspired font, the slogan \"Grow with us\" seamlessly integrated below the company name, vibrant color gradients symbolizing growth and innovation, minimalistic design emphasizing clarity and professionalism, high-resolution vector art suitable for digital and print media, showcasing an IT company identity"
