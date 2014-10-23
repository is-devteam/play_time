describe PlayTime::Configuration do
  describe '#app_id' do
    subject { configuration.app_id }

    context 'with string hash' do
      let(:configuration) { PlayTime::Configuration.new({'app_id' => 'app id'}) }

      it 'loads the app id value' do
        expect(subject).to eq 'app id'
      end
    end

    context 'with symbol hash' do
      let(:configuration) { PlayTime::Configuration.new({app_id: 'app id'}) }

      it 'loads the app id value' do
        expect(subject).to eq 'app id'
      end
    end
  end
end
