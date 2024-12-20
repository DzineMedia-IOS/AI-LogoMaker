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
var isProUser : Bool = false


class Url{
    static let appPrivacy = "https://www.trostun.com/privacy-policy/"
    static let appTerms = "https://www.trostun.com/terms-of-use/"
    static let dzmAppStoreUrl = "https://apps.apple.com/no/developer/dzine-media/id1643499681"
}


let hapticFeedbackKey = "hapticFeedbackEnabled"
let onBoardKey = "onBoardKey"

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
let startPrompt = "A black and white sketch of a bouquet of flowers , including large blooming flowers and smaller buds on long stems against a plain background"
let logoPrompt = "a modern text-based logo for Dzine Media, featuring sleek typography with a tech-inspired font, the slogan \"Grow with us\" seamlessly integrated below the company name, vibrant color gradients symbolizing growth and innovation, minimalistic design emphasizing clarity and professionalism, high-resolution vector art suitable for digital and print media, showcasing an IT company identity"

let discoverArr: [ProjectImage] = [
        ProjectImage(id: 1, imageName: "idea1", projectPrompt: "a girl in a swimsuit, swimming underwater, Underwater Diffusion, Sunlight Scattering in Water, photography photo, 32k uhd"),
        ProjectImage(id: 2, imageName: "idea2", projectPrompt: "Photo of boat in bottle, mesmerizing miniature world in glass.Intricately crafted boat with exquisite details sails gracefully onimaginary sea, tiny mast reaching up. Bottle is art displaying skilland precision of masterpiece. Soft diffused light bathes scene,shadows enhance realism of miniaturized vessel. From intricate rigging to tiny waves on bottle sides, elements precisely captured.Photo seizes magic of art form, transporting viewers intoimaginative, wondrous world"),
        ProjectImage(id: 3, imageName: "idea3", projectPrompt: "A striking anime-style full-body illustration of a girl in radiant,gold Saint Seiya-inspired armor with a bold, lingerie-like design,accentuating her exposed chest, waistline, and thighs. Against a vivid, starry sky backdrop, she strikes a commanding pose, hermessy hair adding dynamic energy. Rendered in hyper-HD withcinematic lighting, glittering highlights, god rays, and ray tracing,the artwork showcases intricate textures, rich saturation, film grain,and impeccable anatomical accuracy, creating a mesmerizing andlifelike masterpiece."),
        ProjectImage(id: 4, imageName: "idea4", projectPrompt: "An enchanting transformation from a serene field of still flowers to a lively animated scene. Flower seeds sprout delicate, colorful wings,resembling butterflies, and take flight, dancing gracefully in the wind.As they soar across the scene, they leave behind a shimmering trailof sparkles, creating a magical, dreamlike atmosphere"),
        ProjectImage(id: 5, imageName: "idea5", projectPrompt: "A highly realistic, ultra-detailed photo of Robert Oppenheimer with an atomic explosion subtly depicted on his hat. The image captures intricate details, with lifelike textures and lighting, showcasing a high-quality, 4K resolution portrait."),
        ProjectImage(id: 6, imageName: "idea6", projectPrompt: "A serene watercolor painting depicting a young girl with soft, flowing hair, standing in a lush, sunlit meadow. She is gently releasing a handful of colorful butterflies into the air, their delicate wings glowing in the soft sunlight. The background features a dreamy blend of pastel hues with wildflowers and a light blue sky dotted with faint,fluffy clouds. The scene is rendered in ultra-high detail, with a 32k resolution, capturing every subtle brushstroke and vibrant color transition."),
        ProjectImage(id: 7, imageName: "idea7", projectPrompt: "An athletic full-body splash art of Velma Dinkley, rendered in a fantastical, hyper-detailed style. The piece features bright, complementary colors with dynamic paint splashes, heavy brushstrokes, and dripping effects, blending oil painting textures with a vibrant splash screen aesthetic. Designed as a fantasy concept art masterpiece, the artwork showcases intricate contour details, a realistic yet imaginative look, and a striking Unreal Engine-inspired finish in 8K UHD resolution, evoking the style of DeviantArt’s finest creations."),
        ProjectImage(id: 8, imageName: "idea8", projectPrompt: "A fallen archangel with a decayed, biomechanical appearance, featuring eerie, nightmarish details and glowing yellow eyes that pierce through the darkness. The scene is illuminated by vibrant splashes of teal and magenta, with bioluminescent elements and ethereal light particles adding to its unsettling allure. The composition exudes a surreal, otherworldly atmosphere, inspired by Mschiffer’s style, designed as highly detailed UHD wallpaper art, perfect for captivating and haunting visuals. a comenvironmentent"),
        ProjectImage(id: 9, imageName: "idea9", projectPrompt: "An ultra-high-definition 32k background depicting the Milky Way Galaxy vividly stretching across a star-filled night sky over a surreal, otherworldly seascape. At the center of the scene, a magnificent sailing ship with sails crafted from shimmering, colorful nebulae glows with a celestial aura. The calm, glass-like waters reflect both the ship and the cosmic expanse above, creating an ethereal and immersive mirror effect. The environment is rendered with breathtaking realism, showcasing intricate details, vibrant colors, and a sense of infinite wonder, blending the majestic beauty of space with the tranquility of the sea."),
        ProjectImage(id: 10, imageName: "idea10", projectPrompt: "A flower with crystals on it UHD illustration of a flower adorned with intricate,in the style of delicately rendered landscapes, ethereal illustrations, light city,rendered in cinema4d, light indigo and white, uhd image, flowing fabrics , a real envoirment"),
        ProjectImage(id: 11, imageName: "idea11", projectPrompt: "An abstract depiction of a jellyfish gracefully floating in a sea of vibrant, dynamic colors, surrounded by intricate coral formations. The scene features the signature artistic style of Mike Campau, blending realism with surreal, vivid hues. The jellyfish exhibits fluid, ethereal movements with glowing, translucent tendrils, harmonizing with the colorful underwater environment. Rendered in breathtaking 32k resolution, the composition captures the beauty and wonder of a real aquatic setting with an imaginative and artistic twist."),
        ProjectImage(id: 12, imageName: "idea12", projectPrompt: "A plucky dog in a billowing flight suit paddles its paws in mid-air, floating within the confined, weightless interior of a shuttle. The whimsical scene captures the dog's endearing disorientation as it struggles to find its footing, with tufts of fur and the suit’s fabric drifting freely in zero gravity. The comical charm of determined paws and floating fur highlights the amusing yet heartfelt struggle against weightlessness."),
        ProjectImage(id: 13, imageName: "idea13", projectPrompt: "A highly detailed, side-view close-up of a Rhizostoma pulmo jellyfish, rendered with a gaunt yet brilliantly colored, rubbery-looking body illuminated under dramatic light. The composition combines intricate filigree textures, fractal art elements, and Ebru-inspired patterns, evoking a surreal blend of organic and abstract beauty. Inspired by Richard Mortensen and Quintessa, the scene is richly colored, zoomorphic, and rendered with forensic photographic precision. Enhanced with Fujicolor Superia X-TRA 400 tones and upscaled using AI for high-quality printing, it creates a mesmerizing, light-painted visual on a stark black background."),
        ProjectImage(id: 14, imageName: "idea14", projectPrompt: "A baby dragon, smiling expression, full frontal body, sitting posture, fat body, warm color, Bubble Mart style, very cute, cartoon realistic,rendered with oc renderer, 3D model effect, high-definition details, 8k, White background"),
        ProjectImage(id: 15, imageName: "idea15", projectPrompt: "Whispers of Metallic Giants: Dawn's Enchanted Meadow\" Paint a vivid visual tale where surreal metallic creatures loom tall against the soft hues of dawn in a vast meadow. These towering beings, their surfaces reflecting the sunlight, cast whimsical shadows on the landscape below. Captured from a low angle, their intricate textures and enormous forms contrast against a softly shaded violet sky. Infuse this composition with the enchanting essence of Emma Campbell's style"),
        ProjectImage(id: 16, imageName: "idea16", projectPrompt: "((best quality)), digital illustration, RGB, Dark colors, view of an insanely detailed bridge, vangogh swirls, hyper details, UHD, 8k, style of Clive Barker and Ivan Bilibin"),
        ProjectImage(id: 17, imageName: "idea17", projectPrompt: "Design a whimsical and vibrant bedroom from the world of 'Biomutant.' Create a space that captures the game's unique blend of post-apocalyptic beauty and mutated creatures. Feature a bed with an eclectic mix of salvaged materials and natural elements, surrounded by hanging plants and colorful textiles. Use warm, natural lighting to evoke a sense of adventure and exploration. Adorn the walls with hand-painted murals depicting lush landscapes and fantastical creatures."),
        ProjectImage(id: 18, imageName: "idea18", projectPrompt: "A hyper-realistic sculpture of a girl made from white Versace marble, emerging from a swirling flame. Her fiery hair seems to ignite with energy, sculpted with intricate, porcelain-like details. The figure's complex features are rendered in 8K resolution using Octane, showcasing ultra-realism in every aspect— from the delicate folds of her sculpted marble form to the lifelike, radiant glow of her hair. The scene incorporates realistic environmental lighting and a minimalist, geometric ornamentation in the background, enhancing the figure’s sculptural beauty. The fine details capture the essence of porcelain and marble, blending art with photography in a stunning, lifelike sculptural relief."),
        ProjectImage(id: 19, imageName: "idea19", projectPrompt: "Mystical Meow: Design an abstract scene that evokes a sense of mystery and allure, reminiscent of a cat's enigmatic presence. Incorporate deep, rich colors and layered"),
        ProjectImage(id: 20, imageName: "idea20", projectPrompt: "HyperRealistic hyper detailed epic album cover art of a centered shot of a girl in a long dress with flowers twirling in front of the ethereal bright nebula night sky, crystal glass moon dripping, splash art Brian Kesinger, Tristan Eaton, Tim Doyle, digital art, detailed background , 32k , UHD result"),
        ProjectImage(id: 21, imageName: "idea21", projectPrompt: "Painting type: Alphonse Mucha style poster with the theme of a woman with,[natural skin color]\"blue flower crown on her head"),
        ProjectImage(id: 22, imageName: "idea22", projectPrompt: "A painting, model submerged in water, gracefully interacting with colorful fish, otherworldly beauty, masterpiece, 8k, in the dreamlike style of Salvador Dalí"),
        ProjectImage(id: 23, imageName: "idea23", projectPrompt: "Happy white puppy with superpowers flying through the sky city skyline, coudy sky , real envoirnment"),
        ProjectImage(id: 24, imageName: "idea24", projectPrompt: "An ultra-high-quality digital illustration depicting an insanely detailed flower landscape bathed in the vibrant hues of a breathtaking sunset. The scene is infused with bright RGB colors and swirling, dreamlike patterns reminiscent of Van Gogh's signature strokes, combined with the surreal and intricate style of Clive Barker. The landscape is a wild dream brought to life, with hyper-detailed flowers and natural elements blending seamlessly into the vivid, swirling circles of the sky. Rendered in UHD 8K resolution, this composition captures the beauty and mystique of a natural view in stunning, surreal detail."),
        ProjectImage(id: 25, imageName: "idea25", projectPrompt: "Blossoming Horizon: Beyond Reality: Craft an awe-inspiring 8K image.Woman is standing here , Background her , a profusion of bioluminescent flowers blooms, replacing conventional organs. The air is alive with the fluttering of tiny butterflies, their pixel art wings capturing a sense of motion and enchantment. Volumetric lighting plays across the scene, rendering a mesmerizing tableau that seamlessly blends , 8k , UHD , natural scenario"),
        ProjectImage(id: 26, imageName: "idea26", projectPrompt: "The eyes shine with soft glow, breathtaking reflections, hyperrealistic cinematography, an ultra-detailed, ultra-realistic photographic image of a middle age girl, beautiful face, beautiful gray eyes, formal attire dress, long hair, fog wearing a crown and smoky background , 32k abstract art , natural"),
        ProjectImage(id: 27, imageName: "idea27", projectPrompt: "Hyper-detailed sculpture of a powerful Greek god with an intricately crafted, stoic face exuding godlike strength. Chest-up portrait showcasing photorealistic textures and masterful craftsmanship, with shadows enhancing depth and grandeur. Dim red ambient light adds ancient mystique. Background features blurred ancient Greek structures in warm brown tones. Rendered in 32K resolution for breathtaking detail and divine artistry."),
        ProjectImage(id: 28, imageName: "idea28", projectPrompt: "Create a captivating scene of illuminated castles nestled among wild, oversized mushrooms, surrounded by vibrant greenery in a lush, natural environment. The castles feature intricate, glowing details, blending a fancy, ornate style with the magical charm of the setting. Soft, atmospheric lighting enhances the rich textures of the mushrooms and foliage, casting a dreamlike glow. Rendered in stunning 4K resolution, the composition captures the harmony between fantastical architecture and the natural world, creating an enchanting and immersive visual experience."),
        ProjectImage(id: 29, imageName: "idea29", projectPrompt: "Create an ultra-high-quality digital image of a fairy princess with a delicate flower crown adorning her head and shimmering dragonfly wings gracefully emerging from her back. She has a fair skin tone, striking blue eyes, and vibrant, multi-colored hair that complements her equally colorful eyes. Her flawless skin glows softly, and a single lily is tucked into her hair, accompanied by intricate flower jewelry. Set in a dark, mystical forest with a marshy landscape, the scene sparkles with the soft light of fireflies and magical glimmers. Rendered with ultra-detailed textures and a natural, immersive environment in UHD, the composition captures an enchanting, otherworldly beauty"),
        ProjectImage(id: 30, imageName: "idea30", projectPrompt: "Templesmith goddess of divine worlds, with detailed facial skin, in a fantastic dress woven with fractal energy, the girl radiates a phantom aura of Light painting her soul. In the background space structures of planets of unexplored civilizations in the style of Paul Lehr glow and radiate magical light, penetrating all the space around. Hyperdetailed photorealism, 108 megapixels, amazing depth, glowing rich colors, powerful imagery, psychedelic Overtones"),
        ProjectImage(id: 31, imageName: "idea31", projectPrompt: "Futuristic aerospace fighter with gilt texture, dynamic light and shadow effects, ultra-detailed design."),
        ProjectImage(id: 32, imageName: "idea32", projectPrompt: "Black-and-white pencil sketch of a three-eyed owl perched on the Tree of Life, intricate and detailed."),
        ProjectImage(id: 33, imageName: "idea33", projectPrompt: "A small green transparent perfume bottle surrounded by white lilies, with a single lily on the right side, illuminated by warm sunlight in 32K UHD clarity."),
        ProjectImage(id: 34, imageName: "idea34", projectPrompt: "Scifi cyberpunk futuristic cybernetic samirai armor with samurai armor riding an motorcycle, key art, splash art, amazing artstation concept art"),
        ProjectImage(id: 35, imageName: "idea35", projectPrompt: "A charming mermaid gracefully swimming with friendly fish in a vibrant underwater paradise, captured in stunning 32K UHD."),
        ProjectImage(id: 36, imageName: "idea36", projectPrompt: "RAW Photo, taken with Provia, trending on CGSociety, a close up of a black rose , made of dark black, trending digital fantasy 3D render photo, full of colorful vegetation, computer vision, looking directly at the viewer, rave inspired, bioart, the artist has used bright, prana, best of ArtStation, garish, cinematic lighting , all boundries lighlighted with pink color , fancy DSLR ,cinematic effect"),
        ProjectImage(id: 37, imageName: "idea37", projectPrompt: "Galaxy starry night by Vincent van Gogh"),
        ProjectImage(id: 38, imageName: "idea38", projectPrompt: "The Elden Ring: An expansive fantasy universe, intricate lore, challenging gameplay, unique character design, rich storytelling"),
        ProjectImage(id: 39, imageName: "idea39", projectPrompt: "Action-realism intensive, Hyper realistic-cinematic overdetailed intricate details. Breathtaking reflections and masterpiece imagery, stunning expression. Over detailed, ultra-realistic, hyper-realistic, Octane render, Natural light photo of the Viking is furious"),
        ProjectImage(id: 40, imageName: "idea40", projectPrompt: "A vast blue expanse stretched as far as the eye could see, its surface shimmering in the light of the rising sun. Gentle waves rolled across the water, their rhythm a soothing accompaniment to the cries of seagulls wheeling above. A light salty breeze carried the tang of the ocean on every inhale. An air of tranquility and raw natural beauty pervaded the scene, evoking feelings of awe for the power , evening sky , birds on sky , rest sun"),
       
        ProjectImage(id: 41, imageName: "idea41", projectPrompt: "Create an ink landscape painting featuring towering mountains, a serene river, and a small boat gliding through it. Geese gracefully across the sky, their flight captured in arcs that evoke freedom and vitality. The scene should convey tranquility, harmony, and the profound depth of nature, with varying ink tones and delicate lines to reflect the mirror-like water, the peaceful atmosphere, and the harmonious coexistence of all elements."),
        ProjectImage(id: 42, imageName: "idea42", projectPrompt: "Beautiful boy with glasses and is standing in the garden, Disney Cartoon style, children’s book illustration"),
        ProjectImage(id: 43, imageName: "idea43", projectPrompt: "A beautiful girl with her back fully covered in an intricate, colorful  Yakuza tattoo, featuring a dragon, flames, a butterfly, and a katana. The vivid design stands out against a clean background, emphasizing its bold and detailed artistry."),
        ProjectImage(id: 44, imageName: "idea44", projectPrompt: "A digital illustration of a yellow flower with soft orange and beige tones, showcasing delicate floral realism, flowing fabrics, porcelain textures, and a vibrant color palette."),
        ProjectImage(id: 45, imageName: "idea45", projectPrompt: "A detailed, painterly full-body portrait of a Panther chameleon in vibrant orange and cyan hues, inspired by Jean-Paul Laurens and Henry Ossawa Tanner, using professional chiaroscuro techniques to showcase dynamic lighting and rich colors."),
        ProjectImage(id: 46, imageName: "idea46", projectPrompt: "A dynamic full-body shot of a girl with long, glowing green hair holding a green fireball, surrounded by a fire-lit environment, radiating magic with a smug expression and powerful stance, enhanced by neon and dark romantic lighting, highlighting vivid eyes, detailed landscape, and realistic gradients for a colorful, dramatic masterpiece."),
        ProjectImage(id: 47, imageName: "idea47", projectPrompt: "A beauty playing with water in a vibrant, candy-colored scene inspired by Popmart, Disney, and Pixar, rendered in 3D with C4D, featuring a neon palette, realistic details, soft lighting, high saturation, and soft focus, with a clear background and 8K HDR resolution that showcases the super-detailed, magical atmosphere."),
        ProjectImage(id: 48, imageName: "idea48", projectPrompt: "A classical Chinese beauty with a round face, balanced features, and soft, graceful contours, exuding timeless allure, serenity, and poise, embodying traditional beauty with a subtle, captivating charm."),
        ProjectImage(id: 49, imageName: "idea49", projectPrompt: "A hyperrealistic girl inspired by Lee Bogle's goddess of worlds, with vivid blue eyes, intricate skin details, and a fractal-energy woven dress, radiating a phantom aura of light. Glowing planets and space structures in the style of Dan Mumford fill the cosmic background, creating a magical, realistic scene full of wonder."),
        ProjectImage(id: 50, imageName: "idea50", projectPrompt: "A 16-year-old anime princess with big eyes and long hair, wearing an embellished strapless ball gown in light gold and white tones, featuring beautiful, detailed clothing with flowing silk. The illustration is in a flat style with realistic details, inspired by Xiaofei Yue, YuumeiArt, and Yoji Shinkawa."),
       
      ]

let logoStylePrompts = [
    "No Style: Create a simple and generic logo with no specific stylistic theme.",
    "Abstract: Design a logo with abstract shapes and creative interpretations, focusing on uniqueness and conceptual elements.",
    "Art Deco: Incorporate bold geometric shapes, metallic colors, and a vintage elegance reminiscent of the 1920s art deco era.",
    "Classic (Text and Logo Design): Create a timeless logo with a combination of sophisticated text and a simple, elegant logo design.",
    "Corporate: Design a professional and polished logo that conveys trust, stability, and business acumen.",
    "Elegant: Create a refined and graceful logo with soft colors, delicate typography, and a luxurious feel.",
    "Futuristic: Design a sleek, modern logo with a high-tech and forward-thinking vibe, utilizing sharp lines and bold elements.",
    "Minimalist: Create a clean and simple logo with minimal elements, focusing on clarity and subtlety.",
    "Geometric: Use geometric shapes and patterns to design a structured, symmetrical, and visually balanced logo.",
    "Grunge: Design a logo with rough textures, distressed effects, and an edgy, rebellious style.",
    "Hand Drawn: Create a logo with a handcrafted feel, using sketch-like designs, playful lines, or artistic illustrations.",
    "Mascot (Must Have Text): Design a logo featuring a character or mascot paired with complementary text that reflects the brand identity.",
    "Minimal: Focus on extreme simplicity, using only the most essential design elements to convey the brand's essence.",
    "Modern: Design a contemporary logo with clean lines, trendy elements, and a fresh, innovative style.",
    "Monogram (Initials of the Brand Name): Create a logo using the initials of the brand name, crafted into a cohesive and stylish monogram.",
    "Nature: Incorporate elements of the natural world such as leaves, trees, water, or animals to create an organic and harmonious logo.",
    "Vintage: Design a logo with a nostalgic and retro aesthetic, using vintage typography, aged textures, and classic motifs."
]


// MARK: 32 Discover ideas

let imgPrompts: [Style] = [
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
