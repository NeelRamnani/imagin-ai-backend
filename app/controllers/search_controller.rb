class SearchController < ApplicationController
    before_action :set_clients
  
    def search
      query = params[:query]
      embed_model = 'your-embed-model'  # Adjust this as needed
      main_model = 'your-main-model'    # Adjust this as needed
  
      # Embedding the query
      query_embed = @ollama_client.embeddings(model: embed_model, prompt: query).first['embedding']
  
      # Searching in the Qdrant collection
      collection_name = "buildragwithpython"
      results = @qdrant_client.points.search(
        collection_name: collection_name,
        limit: 5,
        vector: query_embed,
        with_payload: true
      )
  
      docs = results.map { |doc| doc['payload'] }.join("\n\n")
      model_query = "#{query} - Answer that question using the following text as a resource: #{docs}"
  
      # Generating response from Ollama
      response = @ollama_client.generate(model: main_model, prompt: model_query, stream: true)
  
      response.each do |chunk|
        if chunk['response'].present?
          puts chunk['response'], flush: true
        end
      end
    end
  
    private
  
    def set_clients
      @ollama_client = Ollama.new(
        credentials: { address: 'http://localhost:11434' },  # Local Ollama address
        options: { server_sent_events: true }
      )
  
      @qdrant_client = Qdrant::Client.new(
        url: "http://localhost:6333",  # Default Qdrant port
        api_key: nil  # No API key needed for local non-secured instances
      )
    end
  end