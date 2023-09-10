//
//  Breed.swift
//  CatsApp
//
//  Created by Cecile on 07/09/2023.
//

import Foundation
import RealmSwift

// MARK: - Breed

final class Breed: Object, Codable, Identifiable {

    @Persisted(primaryKey: true) var id: String

    @Persisted var name: String?
    @Persisted var weight: BreedWeight?
    @Persisted var cfaUrl: String?
    @Persisted var vetstreetUrl: String?
    @Persisted var vcahospitalsUrl: String?
    @Persisted var temperament: String?
    @Persisted var origin: String?
    @Persisted var countryCodes: String?
    @Persisted var countryCode: String?
    @Persisted var breedDescription: String?
    @Persisted var lifeSpan: String?
    @Persisted var indoor: Int?
    @Persisted var lap: Int?
    @Persisted var altNames: String?
    @Persisted var adaptability: Int?
    @Persisted var affectionLevel: Int?
    @Persisted var childFriendly: Int?
    @Persisted var catFriendly: Int?
    @Persisted var dogFriendly: Int?
    @Persisted var energyLevel: Int?
    @Persisted var grooming: Int?
    @Persisted var healthIssues: Int?
    @Persisted var intelligence: Int?
    @Persisted var sheddingLevel: Int?
    @Persisted var socialNeeds: Int?
    @Persisted var strangerFriendly: Int?
    @Persisted var vocalisation: Int?
    @Persisted var experimental: Int?
    @Persisted var hairless: Int?
    @Persisted var natural: Int?
    @Persisted var rare: Int?
    @Persisted var rex: Int?
    @Persisted var suppressedTail: Int?
    @Persisted var shortLegs: Int?
    @Persisted var wikipediaUrl: String?
    @Persisted var hypoallergenic: Int?
    @Persisted var referenceImageId: String?
    @Persisted var images: List<BreedImage> = List()

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case weight
        case cfaUrl = "cfa_url"
        case vetstreetUrl = "vetstreet_url"
        case vcahospitalsUrl = "vcahospitals_url"
        case temperament
        case origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case breedDescription = "description"
        case lifeSpan = "life_span"
        case indoor
        case lap
        case altNames = "alt_names"
        case adaptability
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case catFriendly = "cat_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming
        case healthIssues = "health_issues"
        case intelligence
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation
        case experimental
        case hairless
        case natural
        case rare
        case rex
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case wikipediaUrl = "wikipedia_url"
        case hypoallergenic
        case referenceImageId = "reference_image_id"
    }

    override init() {
            super.init()
    }

    init(id: String, name: String? = nil, weight: BreedWeight? = nil, cfaUrl: String? = nil,
         vetstreetUrl: String? = nil, vcahospitalsUrl: String? = nil, temperament: String? = nil,
         origin: String? = nil, countryCodes: String? = nil, countryCode: String? = nil,
         breedDescription: String? = nil, lifeSpan: String? = nil, indoor: Int? = nil, lap: Int? = nil,
         altNames: String? = nil, adaptability: Int? = nil, affectionLevel: Int? = nil,
         childFriendly: Int? = nil, catFriendly: Int? = nil, dogFriendly: Int? = nil,
         energyLevel: Int? = nil, grooming: Int? = nil, healthIssues: Int? = nil, intelligence: Int? = nil,
         sheddingLevel: Int? = nil, socialNeeds: Int? = nil, strangerFriendly: Int? = nil,
         vocalisation: Int? = nil, experimental: Int? = nil, hairless: Int? = nil, natural: Int? = nil,
         rare: Int? = nil, rex: Int? = nil, suppressedTail: Int? = nil, shortLegs: Int? = nil,
         wikipediaUrl: String? = nil, hypoallergenic: Int? = nil, referenceImageId: String? = nil,
         images: List<BreedImage> = List()) {
        super.init()

        self.id = id
        self.name = name
        self.weight = weight
        self.cfaUrl = cfaUrl
        self.vetstreetUrl = vetstreetUrl
        self.vcahospitalsUrl = vcahospitalsUrl
        self.temperament = temperament
        self.origin = origin
        self.countryCodes = countryCodes
        self.countryCode = countryCode
        self.breedDescription = breedDescription
        self.lifeSpan = lifeSpan
        self.indoor = indoor
        self.lap = lap
        self.altNames = altNames
        self.adaptability = adaptability
        self.affectionLevel = affectionLevel
        self.childFriendly = childFriendly
        self.catFriendly = catFriendly
        self.dogFriendly = dogFriendly
        self.energyLevel = energyLevel
        self.grooming = grooming
        self.healthIssues = healthIssues
        self.intelligence = intelligence
        self.sheddingLevel = sheddingLevel
        self.socialNeeds = socialNeeds
        self.strangerFriendly = strangerFriendly
        self.vocalisation = vocalisation
        self.experimental = experimental
        self.hairless = hairless
        self.natural = natural
        self.rare = rare
        self.rex = rex
        self.suppressedTail = suppressedTail
        self.shortLegs = shortLegs
        self.wikipediaUrl = wikipediaUrl
        self.hypoallergenic = hypoallergenic
        self.referenceImageId = referenceImageId
        self.images = images
    }

}

// MARK: - Breed Weight

final class BreedWeight: EmbeddedObject, Codable {

    @Persisted var imperial: String?
    @Persisted var metric: String?

    override init() {
            super.init()
    }

    init(imperial: String? = nil, metric: String? = nil) {
        super.init()

        self.imperial = imperial
        self.metric = metric
    }

}

// MARK: - Breed Image

final class BreedImage: EmbeddedObject, Codable {

    @Persisted var id: String?
    @Persisted var width: Int?
    @Persisted var height: Int?
    @Persisted var url: String?

    override init() {
            super.init()
    }

    init(id: String? = nil, width: Int? = nil, height: Int? = nil, url: String? = nil) {
        super.init()

        self.id = id
        self.width = width
        self.height = height
        self.url = url
    }

}

// MARK: - Breed Extension

extension Breed {

    static let mockedData: Breed = Breed(id: "beng", name: "Bengal",
                                         weight: BreedWeight(imperial: "6 - 12", metric: "3 - 7"),
                                         cfaUrl: "http://cfa.org/Breeds/BreedsAB/Bengal.aspx",
                                         vetstreetUrl: "http://www.vetstreet.com/cats/bengal",
                                         vcahospitalsUrl: "https://vcahospitals.com/know-your-pet/cat-breeds/bengal",
                                         temperament: "Alert, Agile, Energetic, Demanding, Intelligent",
                                         origin: "United States", countryCodes: "US", countryCode: "US",
                                         breedDescription: "Bengals are a lot of fun to live with.",
                                         lifeSpan: "12 - 15", indoor: 0, lap: 0, altNames: nil, adaptability: 5,
                                         affectionLevel: 5, childFriendly: 4, catFriendly: 4, dogFriendly: 5,
                                         energyLevel: 5, grooming: 1, healthIssues: 3, intelligence: 5,
                                         sheddingLevel: 3, socialNeeds: 5, strangerFriendly: 3, vocalisation: 5,
                                         experimental: 0, hairless: 0, natural: 0, rare: 0, rex: 0, suppressedTail: 0,
                                         shortLegs: 0, wikipediaUrl: "https://en.wikipedia.org/wiki/Bengal_(cat)",
                                         hypoallergenic: 1, referenceImageId: "O3btzLlsO")

}

// MARK: - Breed Image Extension

extension BreedImage {

    static let mockedData: BreedImage = BreedImage(id: "itfFA4NWS", width: 1280, height: 914,
                                    url: "https://cdn2.thecatapi.com/images/itfFA4NWS.jpg")

    enum Size: String {
        case small
        case med
        case full
    }

}
