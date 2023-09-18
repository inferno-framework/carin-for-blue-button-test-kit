RSpec.describe CarinForBlueButtonTestKit::MustSupportTest do
    puts "Must support test!"
    let(:json_string) do 
        File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_patient_example.json'))
    end 
    
    let(:patient_resource) { FHIR.from_contents(json_string) }
    
    it 'prints out the contents' do
        puts json_string
    end

    it 'creates a resource' do 
        puts patient_resource.id
    end
end
