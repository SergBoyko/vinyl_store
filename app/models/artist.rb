# == Schema Information
#
# Table name: artists
#
#  id         :bigint           not null, primary key
#  name       :string
#  profile    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artist < ApplicationRecord
end
