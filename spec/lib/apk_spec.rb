describe PlayTime::Apk do
  describe '#load' do
    let(:path) { 'path/to/apk' }

    subject { PlayTime::Apk.load }

    before do
      allow(PlayTime.configuration).to receive(:apk_path).and_return(path)
    end

    it 'returns a Google::APIClient::UploadIO with the path and MIME_TYPE' do
      allow(Google::APIClient::UploadIO).to receive(:new)

      subject

      expect(Google::APIClient::UploadIO).to have_received(:new).with(path, PlayTime::Apk::MIME_TYPE)
    end
  end
end
