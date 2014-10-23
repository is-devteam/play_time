describe PlayTime, if: PlayTime.config_path.end_with?('default.yml') do
  describe '.configuration' do
    subject { PlayTime.configuration }

    it 'provides a nice getter for the app id' do
      expect(subject.app_id).to eq 'app id'
    end
  end

  describe '.deploy' do
    let(:deploy) { instance_double(PlayTime::Deploy) }

    subject { PlayTime.deploy(track) }

    before do
      allow(PlayTime::Deploy).to receive(:new).and_return(deploy)
    end

    context 'with alpha track' do
      let(:track) { PlayTime::Track::ALPHA }

      it 'deploys the track' do
        allow(deploy).to receive(:deploy)

        subject

        expect(deploy).to have_received(:deploy).with(track)
      end
    end
  end
end
