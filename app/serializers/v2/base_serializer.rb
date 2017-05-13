class V2::BaseSerializer < ApplicationSerializer

  def link(rel, href)
    { rel: rel, href: href }
  end
end