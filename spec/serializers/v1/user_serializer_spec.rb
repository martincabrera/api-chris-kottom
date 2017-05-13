require 'rails_helper'
include Rails.application.routes.url_helpers

RSpec.describe V1::UserSerializer, :type => :serializer do
  let(:user) {FactoryGirl.create(:admin)}

  it "serializes all visible attributes for a User" do

    serializer = V1::UserSerializer.new(user)
    serialized_user = serializer.as_json
    user.attributes.keys.each do |key|
      next if key == "password_digest"
      expect(serialized_user[key.to_sym]).to eq user.send(key)
    end

  end

  it "includes self link and boards link for the User" do
    serialized_links = serialized_user[:links]
    expect(serialized_links.count).to eq 2

    self_url = serialized_links.find {|url| url[:rel] == :self}
    expect(self_url).to_not be_nil
    expect(self_url[:href]).to eq v1_user_url(user)

    boards_url = serialized_links.find {|url| url[:rel] == :boards}
    expect(boards_url).to_not be_nil
    expect(boards_url[:href]).to eq v1_user_boards_url(user)
  end

  it "includes currently active boards created by the user" do
    FactoryGirl.create(:active, creator: user)
    active_boards = serialized_user[:active_boards]
    expect(1).to eq active_boards.count

    expected_ids = user.boards.where(archived: false).pluck(:id)
    expect(expected_ids).to match_ids(active_boards)

    expect(%i(id title links)).to match_keys(active_boards.first.keys)
  end


  private

  def serialized_user(local_user = nil)
    local_user ||= user
    V1::UserSerializer.new(local_user).as_json
  end

end