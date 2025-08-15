module TopicSuggestionService
  class << self
    SEARCH_PROMPT = %(
    You are powerful semantic search and thesaurus robot.
    You reply in JSON format with the field 'topic'.
    Given some text you will identify the key
    skills, talents, and competencies related to the text.

    Based on your thorough understanding of the text select the topic from the following list the best matches
    the knowledge domain mentioned in the text. Please sumit your answer in the follow JSON format: {"topic": "TOPIC"}
    You reply with  exactly one word response which is best matching topic from the list.
    here is the topic list you must choose from:
    ["Animation",
      Architecture",
      Berlin",
      Birdwatching",
      Charleston",
      Chicago",
      Child Healthcare",
      Climate Change",
      Copenhagen",
      Corporate Training",
      Craft Beer Brewing",
      Cycling",
      Design",
      E-Commerce",
      Engineering",
      Fashion",
      Fashion Design",
      Fintech",
      Gardening",
      Golf",
      Graphic Design",
      Heart Disease",
      Hiking",
      History",
      Jazz Music",
      Journalism",
      Medicine",
      New York",
      Painting",
      Photography",
      Piano",
      Portland",
      Pottery",
      Rock Climbing",
      Sailing",
      Salsa Dancing",
      San Diego",
      Seattle",
      Software Engineering",
      Sustainable Fashion",
      Urban Design",
      Urban Sustainability",
      User Experience",
      Washington D.C.",
      Yoga"
      ]

      Here is the search text:


    ).freeze

    def suggest(search_qry)
      return nil unless search_qry

      search_prompt = build_search_prompt(search_qry)
      completion = AiService.completion(search_prompt)
      data = AiService.parse_completion(completion)
      topic = data[:topic]
      Rails.logger.debug('Topic is ${topic}')
      topic
    end

    def build_search_prompt(search)
      "#{SEARCH_PROMPT} \n __\n #{search} \n"
    end
  end
end
