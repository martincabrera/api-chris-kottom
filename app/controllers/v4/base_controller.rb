class V4::BaseController < ApplicationController
  include JSONAPI::ErrorRendering
  prepend JSONAPI::Rendering
end