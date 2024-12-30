# == Schema Information
#
# Table name: discs
#
#  id                 :bigint           not null, primary key
#  condition          :string
#  country            :string
#  cover_url          :string
#  genres             :string           default([]), is an Array
#  notes              :string
#  price              :integer
#  released           :string
#  released_formatted :string
#  styles             :string           default([]), is an Array
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  artist_id          :bigint           not null
#
# Indexes
#
#  index_discs_on_artist_id  (artist_id)
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id)
#
class Disc < ApplicationRecord
  belongs_to :artist
  has_many :tracks, dependent: :destroy
end
