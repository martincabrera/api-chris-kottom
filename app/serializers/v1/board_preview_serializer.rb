class V1::BoardPreviewSerializer < V1::BaseSerializer

  attributes :id, :title
  attributes  :links

  def links
    [
        link(:self, v1_board_url(object)),
    ]
  end
end
