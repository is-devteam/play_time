describe PlayTime::Configuration do
  describe '#app_id' do
    subject { configuration.app_id }

    context 'with string hash' do
      let(:configuration) { PlayTime::Configuration.new({'app_id' => 'app id'}) }

      it 'loads the app id value' do
        expect(subject).to eq 'app id'
      end
    end
  end

  describe '#apk_path' do
    let(:apk_path) { 'apk_path' }
    let(:track) { 'track' }
    let(:configuration) { PlayTime::Configuration.new({ track => apk_path }) }

    subject { configuration.apk_path(track: track) }

    before do
      allow(PlayTime::Track).to receive(:validate!)
    end

    it 'returns the apk path' do
      expect(subject).to eq apk_path
    end

    it 'validates the track' do
      subject

      expect(PlayTime::Track).to have_received(:validate!).with(track)
    end
  end
end
