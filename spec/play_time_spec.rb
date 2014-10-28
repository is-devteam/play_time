describe PlayTime, if: PlayTime.config_path.end_with?('default.yml') do
  describe '.configuration' do
    subject { PlayTime.configuration }

    it 'returns a PlayTime::Configuration object' do
      expect(subject).to be_a PlayTime::Configuration
    end
  end

  describe '.upload' do
    let(:track) { PlayTime::Track::ALPHA }

    subject { PlayTime.upload(track) }

    it 'uploads the apk with the track' do
      allow(PlayTime::Upload).to receive(:upload)

      subject

      expect(PlayTime::Upload).to have_received(:upload).with(track)
    end
  end

  describe '.promote' do
    let(:version_code) { 99 }
    let(:track) { PlayTime::Track::BETA }

    subject { PlayTime.promote(version_code, track) }

    it 'promotes the version code' do
      allow(PlayTime::Promote).to receive(:promote)

      subject

      expect(PlayTime::Promote).to have_received(:promote).with(version_code, track)
    end
  end
end
