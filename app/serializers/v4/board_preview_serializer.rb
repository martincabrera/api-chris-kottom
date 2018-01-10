class V4::BoardPreviewSerializer < V4::BaseSerializer

  attributes :id, :title, :archived
  attributes  :links

  def links
    [
        link(:self, v4_board_url(object)),
    ]
  end
end
