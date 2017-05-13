class V2::BoardPreviewSerializer < V2::BaseSerializer

  attributes :id, :title
  attributes  :links

  def links
    [
        link(:self, v2_board_url(object)),
    ]
  end
end
