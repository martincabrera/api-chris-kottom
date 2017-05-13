require 'rspec/expectations'

RSpec::Matchers.define :match_ids do |expected|
        actual_ids = expected.map {|rec| rec.fetch(:id)}

  match do |actual|
    actual.sort == actual_ids
  end
  failure_message do |actual|
    "IDs don't match #{actual} -  #{expected}"
  end
end


RSpec::Matchers.define :match_keys do |expected|

  match do |actual|
    actual.sort == expected.sort
  end
  failure_message do |actual|
    "Keys don't match #{actual.sort} -  #{expected.sort}"
  end
end


RSpec::Matchers.define :match_link do |expected|

  match do |actual|
    expected.include? actual
  end
  failure_message do |actual|
    "#{expected} does not include #{actual}"
  end
end

