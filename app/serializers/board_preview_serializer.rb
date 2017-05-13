class BoardPreviewSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title
  attributes  :links



  def link(rel, href)
    { rel: rel, href: href }
  end

  def links
    [
        link(:self, board_url(object)),
    ]
  end

end
