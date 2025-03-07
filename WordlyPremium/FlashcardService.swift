//
//  apiHandle.swift
//  WordlyPremium
//
//  Created by Jahongir Abdujalilov on 06/03/25.
//

import Alamofire

class FlashcardService {
    private let apiKey = "your-deepseek-api-key"
    private let apiUrl = "https://api.deepseek.com/v1/completions" // Example URL

    func generateCards(request: GenerateCardsRequest, completion: @escaping (Result<[Flashcard], Error>) -> Void) {
        // Construct the prompt
        let numCardsPrompt = request.numCards == 0 ? "an appropriate number of" : "\(request.numCards)"
        let prompt = "Generate \(numCardsPrompt) \(request.fromLanguage) to \(request.toLanguage) flashcards about \(request.topic), focusing on \(request.wordType)."

        // Prepare the request body
        let requestBody: [String: Any] = [
            "prompt": prompt,
            "max_tokens": 1000
        ]

        // Define headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json"
        ]

        // Send the request using Alamofire
        AF.request(apiUrl, method: .post, parameters: requestBody, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    // Parse the response
                    if let json = value as? [String: Any],
                       let choices = json["choices"] as? [[String: Any]] {
                        var cards: [Flashcard] = []
                        for choice in choices {
                            if let text = choice["text"] as? String {
                                let lines = text.components(separatedBy: "\n")
                                for line in lines {
                                    let parts = line.components(separatedBy: ":")
                                    guard parts.count == 2 else { continue }
                                    let flashcard = Flashcard(question: parts[0], answer: parts[1])
                                    cards.append(flashcard)
                                }
                            }
                        }
                        completion(.success(cards))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
