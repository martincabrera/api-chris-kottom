require 'rspec/expectations'

module Serialization
  module Helpers
    def serialized_data(model, serializer_klass = nil)
      if !serializer_klass
        serializer_klass = ActiveModel::Serializer.serializer_for(model)
      end
      serializer = serializer_klass.new(model)
      serializer.as_json
    end
  end


  module Matchers
    extend RSpec::Matchers::DSL

    matcher :match_ids do |expected|
      actual_ids = expected.map {|rec| rec.fetch(:id)}
      match {|actual| actual.sort == actual_ids}
    end

    matcher :match_keys do |expected|
      match {|actual| actual.sort == expected.sort}
    end

    matcher :match_link do |expected|
      match { |actual| expected.include? actual }
    end


  end
end


#assert_ids expected_ids, active_boards