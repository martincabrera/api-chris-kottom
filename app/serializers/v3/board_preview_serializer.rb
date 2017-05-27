class V3::BoardPreviewSerializer < V3::BaseSerializer

  attributes :id, :title
  attributes  :links

  def links
    [
        link(:self, v3_board_url(object)),
    ]
  end
end
