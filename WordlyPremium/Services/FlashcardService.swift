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

    // Add some constants to standardize parameters
    private struct Constants {
        static let defaultCardCount = "10"
        static let defaultWordType = "Mixed"
        static let maxTokens = 1000  // Increased for better responses
    }

    func generateCards(
        request: GenerateCardsRequest,
        completion: @escaping (Result<([FlashcardEntity], String), Error>) -> Void
    ) {
        // Validate request parameters
        let safeFromLanguage =
            request.fromLanguage?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "English"
        let safeToLanguage =
            request.toLanguage?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Spanish"
        let safeTopic =
            request.topic?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Common Phrases"
        let safeCardType =
            request.cardType?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Mixed"

        // Clean up numeric values and handle empty values
        let numCardsPrompt: String
        if let numCards = request.numCards, !numCards.isEmpty, numCards != "0" {
            numCardsPrompt = numCards
        } else {
            numCardsPrompt = Constants.defaultCardCount
        }

        // Handle word types - make sure there's at least one if appropriate
        var safeWordTypes = request.wordTypes
        if safeCardType.lowercased() == "single word" && safeWordTypes.isEmpty {
            safeWordTypes.insert(Constants.defaultWordType)
        }
        let wordTypesString =
            safeWordTypes.isEmpty ? "" : "focusing on \(safeWordTypes.joined(separator: ", "))"

        // Create a cleaner, more specific prompt
        let prompt = """
            Generate \(numCardsPrompt) flashcards translating from \(safeFromLanguage) to \(safeToLanguage).
            Topic: \(safeTopic)
            Type of content: \(safeCardType)
            \(wordTypesString)
            Please ensure all cards are accurate and natural in both languages.
            """

//        print("📝 Generating with prompt: \(prompt)")

        let systemContent = """
            You are a helpful language learning assistant that creates flashcards.

            The user will provide the topic and parameters to create Flashcards
            Parameters: Topic, fromLanguage, toLanguage, CardsAmount, and WordType, CardType

            Parameter options:
            CardsAmount - Specific number of cards to generate (default: 10)
            CardType - Single word, Phrase, Sentence, Mixed
            WordType - Noun, Verb, Adjective, Adverb, Mixed (relevant when Single word is selected)

            Ensure that:
            1. All translations are accurate and natural
            2. The level of difficulty is appropriate for the topic
            3. Cards are diverse and cover the topic comprehensively
            4. Only return well-formed JSON in the required format

            RESPONSE FORMAT (STRICT JSON):
            {
                "packName": "Topic Name",
                "flashCards": [
                    {
                        "langFrom": "Word or phrase in source language",
                        "langTo": "Translation in target language"
                    },
                    ...
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
            "max_tokens": Constants.maxTokens,
            "temperature": 0.7,  // Add some creativity but not too much
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json",
        ]

        // Show what we're sending for debugging
        print("🔄 Sending request to API...")

        AF.request(
            apiUrl, method: .post, parameters: requestBody, encoding: JSONEncoding.default,
            headers: headers
        )
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    // Parse the outer JSON to extract the content string
                    let json =
                        try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                    guard let choices = json?["choices"] as? [[String: Any]],
                        let message = choices.first?["message"] as? [String: Any],
                        let contentString = message["content"] as? String,
                        let contentData = contentString.data(using: .utf8)
                    else {
                        print("❌ Failed to extract content string from API response")
                        let error = NSError(
                            domain: "FlashcardService",
                            code: 1001,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid API response format"]
                        )
                        completion(.failure(error))
                        return
                    }

                    // Try to decode as APIFlashcardResponse
                    do {
                        let apiResponse = try JSONDecoder().decode(
                            APIFlashcardResponse.self, from: contentData)
//                        print("✅ Successfully decoded \(apiResponse.flashCards.count) flashcards")

                        // Convert API response to FlashcardEntity objects
                        let flashcardEntities = apiResponse.flashCards.map { apiCard in
                            return FlashcardEntity(
                                question: apiCard.question,
                                answer: apiCard.answer,
                                isStudied: false
                            )
                        }

                        if flashcardEntities.isEmpty {
                            print("⚠️ Warning: API returned an empty list of flashcards")
                            let error = NSError(
                                domain: "FlashcardService",
                                code: 1002,
                                userInfo: [
                                    NSLocalizedDescriptionKey:
                                        "No flashcards could be generated. Please try different parameters."
                                ]
                            )
                            completion(.failure(error))
                        } else {
                            completion(.success((flashcardEntities, apiResponse.packName)))
                        }
                    } catch {
                        print("❌ JSON Decoding Error: \(error)")
                        print("Content that couldn't be parsed: \(contentString)")

                        let nsError = NSError(
                            domain: "FlashcardService",
                            code: 1003,
                            userInfo: [
                                NSLocalizedDescriptionKey:
                                    "Failed to decode API response. Please try again.",
                                NSUnderlyingErrorKey: error,
                            ]
                        )
                        completion(.failure(nsError))
                    }
                } catch {
                    print("❌ JSON Parsing Error: \(error)")
                    completion(.failure(error))
                }

            case .failure(let error):
                print("❌ API Request failed: \(error)")
                // Provide a more user-friendly error message
                let nsError = NSError(
                    domain: "FlashcardService",
                    code: 1004,
                    userInfo: [
                        NSLocalizedDescriptionKey:
                            "Network error. Please check your connection and try again.",
                        NSUnderlyingErrorKey: error,
                    ]
                )
                completion(.failure(nsError))
            }
        }
    }

    // Helper method to handle timeout/retry logic if needed in the future
    func retryRequestIfNeeded(
        _ error: Error, retryCount: Int, maxRetries: Int = 3, completion: @escaping (Bool) -> Void
    ) {
        if retryCount < maxRetries {
            // Could implement exponential backoff or other retry strategies
            let delay = Double(retryCount + 1) * 2.0
            print("⏱ Retrying request after \(delay) seconds...")
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                completion(true)
            }
        } else {
            completion(false)
        }
    }
}
