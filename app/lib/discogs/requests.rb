module Discogs
  class Requests
    def fetch_disc(release_id:)
     connection.get(endpoint_releases(release_id:)).body

    end

    def fetch_artist(artist_id:)
      connection.get(endpoint_artist(artist_id:)).body
    end

    private

    def connection
      @connection ||= Faraday.new(url: url, headers: { 'Authorization' => token }) do |builder|
        builder.request :json
        builder.response :json
      end
    end

    def endpoint_releases(release_id:)
      "releases/#{release_id}"
    end

    def endpoint_artist(artist_id:)
      "artists/#{artist_id}"
    end

    def url = 'https://api.discogs.com/'
    def token = Rails.application.credentials.discogs.token
  end
end