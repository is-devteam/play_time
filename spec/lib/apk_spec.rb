describe PlayTime::Apk do
  describe '#load' do
    let(:path) { 'path/to/*apk' }
    let(:old_file) { instance_double(File, mtime: Time.now - 10, path: 'should not get here') }
    let(:file) { instance_double(File, mtime: Time.now, path: 'newest/file') }

    subject { PlayTime::Apk.load }

    before do
      allow(PlayTime.configuration).to receive(:apk_path).and_return(path)
      allow(File).to receive(:open).with(file.path).and_return(file)
      allow(File).to receive(:open).with(old_file.path).and_return(old_file)
      allow(Dir).to receive(:[]).and_return([file.path, old_file.path])
    end

    it 'returns a Google::APIClient::UploadIO with the path and MIME_TYPE' do
      allow(Google::APIClient::UploadIO).to receive(:new)

      subject

      expect(Google::APIClient::UploadIO).to have_received(:new).with('newest/file', PlayTime::Apk::MIME_TYPE)
    end

    it "searches the directory for the path" do
      subject

      expect(Dir).to have_received(:[]).with path
    end

    context 'when file not found' do
      before do
        allow(Dir).to receive(:[]).and_return([])
      end

      it 'raises an error' do
        expect {
          subject
        }.to raise_error(PlayTime::Apk::FileNotFound, "No such file or directory: #{path}")
      end
    end

    after do
      PlayTime::Apk.instance_variable_set(:@most_recent_modified_file_path, nil)
    end
  end
end
