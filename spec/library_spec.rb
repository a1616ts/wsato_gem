require './lib/wsato_gem/library.rb'
describe 'library' do
  context 'request_to_geocode_api' do
    it 'should call get_request and return result' do
      library = Library.new
      allow(library).to receive(:get_request).and_return('content')
      expect(library.request_to_geocode_api(address: 'test')).to eq('content')
    end
  end
  context 'request_to_calil_api' do
    it 'should call get_request and return result' do
      library = Library.new
      allow(library).to receive(:get_request).and_return('content')
      expect(library.request_to_calil_api(calilapp_key: 'key', geocode: '120,100', libraries_limit: 10)).to eq('content')
    end
  end
  context 'libraries_in_neihborhood' do
    it 'should call get_request with empty hash and return 0' do
      result = Library.new.libraries_in_neihborhood({})
      expect(result.size).to eq(0)
    end
    it 'should call get_request with valid hash and return library information' do
      contents = [
        {
          'systemid' => 'A',
          'libkey'   => 'libkey_A',
          'distance' => 0.3,
          'formal'   => 'A図書館'
        },
        {
          'systemid' => 'A',
          'libkey'   => 'libkey_B',
          'distance' => 0.2,
          'formal'   => 'B図書館'
        },
        {
          'systemid' => 'B',
          'libkey'   => 'libkey_C',
          'distance' => 0.1,
          'formal'   => 'C図書館'
        }
      ]

      libraries  = {
        0.1 => 'C図書館',
        0.2 => 'B図書館',
        0.3 => 'A図書館',
      }
      expect(Library.new.libraries_in_neihborhood(contents)).to eq(libraries)
    end
  end
end
