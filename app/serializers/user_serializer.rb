class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :gravatar_url, :admin, :created_at, :updated_at
  attributes :mailto_url, :links

  has_many :active_boards, serializer: BoardPreviewSerializer do
    object.boards.where(archived: false)
  end

  has_many :archived_boards, serializer: BoardPreviewSerializer do
    object.boards.where(archived: true)
  end

  def link(rel, href)
    { rel: rel, href: href }
  end

  def mailto_url
    "mailto:#{object.email}"
  end

  def links
    [
        link(:self, user_url(object)),
        link(:boards, user_boards_url(object))
    ]
  end

end
