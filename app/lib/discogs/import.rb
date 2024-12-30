module Discogs
  class Import
    attr_reader :release_ids

    def self.call(...)
      new(...).call
    end

    def initialize(release_ids:)
      @release_ids = release_ids
    end

    def call
      release_ids.each { |release_id| process_release(release_id) }
    end

    private

    def process_release(release_id)
      discogs_disc = fetch_disc(release_id)
      disc = build_disc(discogs_disc)
      disc.artist = find_or_build_artist(discogs_disc)
      disc.save!
      create_tracks(discogs_disc['tracklist'], disc)
    end

    def fetch_disc(release_id)
      connection.fetch_disc(release_id:)
    end

    def build_disc(disc_data)
      Disc.new(
        condition: 'Mint (M)',
        country: disc_data['country'],
        cover_url: extract_cover_url(disc_data['images']),
        genres: disc_data['genres'],
        notes: disc_data['notes'],
        price: '999',
        released: disc_data['released'],
        released_formatted: disc_data['released_formatted'],
        styles: disc_data['styles'],
        title: disc_data['title'],
        artist: Artist.first
      )
    end

    def extract_cover_url(images)
      return if images.blank?

      primary_image = images.find { |image| image['type'] == 'primary' }
      primary_image&.dig('uri') || images.first&.dig('uri')
    end

    def find_or_build_artist(discogs_disc)
      disc_artist = find_primary_artist(discogs_disc)
      artist = Artist.find_or_initialize_by(name: disc_artist['name'])

      if artist.new_record?
        enrich_artist_data(artist, disc_artist['id'])
      end

      artist.save
      artist
    end

    def find_primary_artist(discogs_disc)
      discogs_disc['artists'].find do |artist|
        artist['name'] == discogs_disc['artists_sort']
      end
    end

    def enrich_artist_data(artist, artist_id)
      discogs_artist = fetch_artist(artist_id)
      artist.profile = discogs_artist['profile']
      artist.name_variations = discogs_artist['namevariations']
    end

    def fetch_artist(artist_id)
      connection.fetch_artist(artist_id:)
    end

    def create_tracks(tracklist, disc)
      return if tracklist.blank?

      tracklist.each do |track_data|
        Track.create(
          title: track_data['title'],
          duration: track_data['duration'],
          position: track_data['position'],
          disc: disc
        )
      end
    end

    def connection
      @connection ||= Requests.new
    end
  end
end