# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  duration   :string
#  position   :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  disc_id    :bigint           not null
#
# Indexes
#
#  index_tracks_on_disc_id  (disc_id)
#
# Foreign Keys
#
#  fk_rails_...  (disc_id => discs.id)
#
class Track < ApplicationRecord
  belongs_to :disc
end
