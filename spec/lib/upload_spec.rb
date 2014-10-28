
describe PlayTime::Upload do
  describe '.upload' do
    let(:upload) { instance_double(PlayTime::Upload) }
    let(:client) { instance_double(PlayTime::Client) }

    subject { PlayTime::Upload.upload('track') }

    before do
      allow(upload).to receive(:upload)
      allow(PlayTime::Client).to receive(:new).and_return(client)
      allow(PlayTime::Upload).to receive(:new).and_return(upload)
    end

    it 'uploads the track' do
      subject

      expect(upload).to have_received(:upload).with('track')
    end

    it 'instantiates upload with new authorization and client' do
      subject

      expect(PlayTime::Upload).to have_received(:new).with(client)
    end
  end

  describe '#upload' do
    let(:client) { instance_double(PlayTime::Client) }
    let(:upload) { PlayTime::Upload.new(client) }

    subject { upload.upload('track') }

    before do
      allow(client).to receive(:authorize!)
      allow(client).to receive(:commit)
    end

    it 'authroizes the client' do
      subject

      expect(client).to have_received(:authorize!)
    end

    it 'commits the track' do
      subject

      expect(client).to have_received(:commit).with('track')
    end
  end
end

