# == Schema Information
#
# Table name: artists
#
#  id              :bigint           not null, primary key
#  name            :string
#  name_variations :string           default([]), is an Array
#  profile         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Artist < ApplicationRecord
end
