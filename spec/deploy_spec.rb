describe PlayTime::Deploy do
  describe '#deploy' do
    let(:uploader) { instance_double(PlayTime::Uploader) }

    subject { PlayTime::Deploy.new.deploy(track) }

    before do
      allow(PlayTime::Uploader).to receive(:new).and_return(uploader)
    end

    context 'with alpha track' do
      let(:track) { PlayTime::Track::ALPHA }
      let(:apk_path) { '/path/to/app.apk' }

      before do
        allow(PlayTime.configuration).to receive(:apk_path).and_return(apk_path)
        allow(uploader).to receive(:upload)
      end

      it 'gets the apk path for the track' do
        subject

        expect(PlayTime.configuration).to have_received(:apk_path).with(track: track)
      end

      it 'uploads the apk path to the client' do
        subject

        expect(uploader).to have_received(:upload).with(apk_path)
      end
    end
  end
end
