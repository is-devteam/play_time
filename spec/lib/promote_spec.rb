describe PlayTime::Promote do
  let(:version_code) { 99 }
  let(:track) { 'alpha' }

  describe '.promote' do
    let(:promote) { instance_double(PlayTime::Promote) }
    let(:client) { instance_double(PlayTime::Client) }

    subject { PlayTime::Promote.promote(track, version_code) }

    before do
      allow(promote).to receive(:promote)
      allow(PlayTime::Client).to receive(:new).and_return(client)
      allow(PlayTime::Promote).to receive(:new).and_return(promote)
    end

    it 'promotes the track' do
      subject

      expect(promote).to have_received(:promote).with(track, version_code)
    end

    it 'instantiates upload with new authorization and client' do
      subject

      expect(PlayTime::Promote).to have_received(:new).with(client)
    end
  end

  describe '#promote' do
    let(:client) { instance_double(PlayTime::Client) }
    let(:promote) { PlayTime::Promote.new(client) }

    subject { promote.promote(track, version_code) }

    before do
      allow(client).to receive(:authorize!)
      allow(client).to receive(:update)
    end

    it 'authroizes the client' do
      subject

      expect(client).to have_received(:authorize!)
    end

    it 'updates the track with the version code' do
      subject

      expect(client).to have_received(:update).with(track, version_code)
    end
  end
end
