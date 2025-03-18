//
//  FlashcardService.swift
//  WordlyPremium
//
//  Created by Jahongir Abdujalilov on 06/03/25.
//

import Alamofire
import Foundation

class FlashcardService {
    private let apiKey = "sk-e18b6280605d4913821ed0c37e89cffd"
    private let apiUrl = "https://api.deepseek.com/chat/completions"

    func generateCards(
        request: GenerateCardsRequest, completion: @escaping (Result<[Flashcard], Error>) -> Void
    ) {
        let numCardsPrompt =
            request.numCards == "0"
            ? "an appropriate number of" : "\(String(describing: request.numCards))"
        let selectedWordTypes = request.wordTypes.map { $0 }.joined(separator: ", ")
        let prompt =
            "Generate \(numCardsPrompt) \(String(describing: request.fromLanguage)) to \(String(describing: request.toLanguage))  \(String(describing: request.cardType)) flashcards about \(String(describing: request.topic)), focusing on \(String(describing: selectedWordTypes))."

        let systemContent = """
            The user will provide the topic and parameters to create Flashcards
            Parameters: Topic, fromLanguage, toLanguage, CardsAmount, and WordType, CardType

            Parameter options:
            CardsAmount - 0 means automatic
            CardType - Single word, Phrase, Sentence, Mixed
            WordType - Noun, Verb, Adjective, Adverb (these options are available only when Single word card type is selected)

            EXAMPLE INPUT:
            - Single word: "Transport"
            - Full sentence: "Give me the most common words to use in a Barbershop."

            EXAMPLE JSON OUTPUT:
            {
                "packName": "Barbershop",
                "flashCards": [
                    {
                        "langFrom": "hair",
                        "langTo": "cabello"
                    },
                    {
                        "langFrom": "cut",
                        "langTo": "corte"
                    }
                ]
            }
            """

        let requestBody: [String: Any] = [
            "model": "deepseek-chat",
            "messages": [
                ["role": "system", "content": systemContent],
                ["role": "user", "content": prompt],
            ],
            "response_format": ["type": "json_object"],
            "stream": false,
            "max_tokens": 1000,
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json",
        ]

        AF.request(
            apiUrl, method: .post, parameters: requestBody, encoding: JSONEncoding.default,
            headers: headers
        )
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    // First, parse the outer JSON to extract the content string
                    let json =
                        try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("✅ Parsed JSON: \(json ?? [:])")

                    guard let choices = json?["choices"] as? [[String: Any]],
                        let message = choices.first?["message"] as? [String: Any],
                        let contentString = message["content"] as? String,
                        let contentData = contentString.data(using: .utf8)
                    else {
                        print("❌ Failed to extract content string")
                        completion(
                            .failure(
                                NSError(
                                    domain: "", code: -1,
                                    userInfo: [NSLocalizedDescriptionKey: "Invalid response format"]
                                )))
                        return
                    }

                    // Print the extracted JSON content before decoding
                    print("✅ Extracted Content String: \(contentString)")

                    // Second, decode the inner JSON string into our temporary API response model
                    let apiResponse = try JSONDecoder().decode(
                        APIFlashcardResponse.self, from: contentData)
                    print("✅ Successfully Decoded API Response: \(apiResponse)")

                    // Convert API response to Flashcard model with default isStudied value
                    let flashcards = apiResponse.flashCards.map { apiCard in
                        return Flashcard(
                            question: apiCard.question,
                            answer: apiCard.answer,
                            isStudied: false  // Default value for new cards
                        )
                    }

                    completion(.success(flashcards))

                } catch {
                    print("❌ JSON Decoding Error: \(error)")
                    completion(.failure(error))
                }

            case .failure(let error):
                print("❌ Request failed: \(error)")
                completion(.failure(error))
            }
        }
    }
}
