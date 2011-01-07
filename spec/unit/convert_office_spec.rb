require 'spec_helper'

describe ConvertOfficeFormat, 'convert document from one format to another' do
  it 'should convert rtf to pdf' do
    ConvertOfficeFormat.convert('spec/data/observation.rtf', '/tmp/observation.html')
  end
end
