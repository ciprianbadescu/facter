# frozen_string_literal: true

describe 'Windows DmiProductName' do
  context '#call_the_resolver' do
    let(:value) { 'VMware7,1' }
    subject(:fact) { Facter::Windows::DmiProductName.new }

    before do
      allow(Facter::Resolvers::DMIComputerSystem).to receive(:resolve).with(:name).and_return(value)
    end

    it 'calls Facter::Resolvers::DMIComputerSystem' do
      expect(Facter::Resolvers::DMIComputerSystem).to receive(:resolve).with(:name)
      fact.call_the_resolver
    end

    it 'returns product name fact' do
      expect(fact.call_the_resolver).to be_an_instance_of(Array).and \
        contain_exactly(an_object_having_attributes(name: 'dmi.product.name', value: value),
                        an_object_having_attributes(name: 'productname', value: value, type: :legacy))
    end
  end
end