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
      expect(library.request_to_calil_api(calilapp_key: 'key', geocode: '120,100')).to eq('content')
    end
  end
  context 'libraries_in_neihborhood' do
    it '0' do # TODO test case name...
      result = Library.new.libraries_in_neihborhood({})
      expect(result.libraries.size).to eq(0)
      expect(result.libraries_formalname_map.size).to eq(0)
    end
    it '3' do # TODO test case name...
      contents = [
        {
          'systemid' => 'A',
          'libkey'   => 'libkey_A',
          'distance' => 0.1,
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
          'distance' => 0.3,
          'formal'   => 'C図書館'
        }
      ]

      libraries = {
        'Alibkey_A' => 0.1,
        'Alibkey_B' => 0.2,
        'Blibkey_C' => 0.3,
      }
      libraries_formalname_map  = {
        'Alibkey_A' => 'A図書館',
        'Alibkey_B' => 'B図書館',
        'Blibkey_C' => 'C図書館',
      }
      expect(Library.new.libraries_in_neihborhood(contents).libraries).to eq(libraries)
      expect(Library.new.libraries_in_neihborhood(contents).libraries_formalname_map).to eq(libraries_formalname_map)
    end
  end
  
end
