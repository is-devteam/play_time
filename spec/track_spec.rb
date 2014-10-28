describe PlayTime::Track do
  describe '.validate!' do
    subject { PlayTime::Track.validate!(track) }

    context 'when alpha' do
      let(:track) { 'alpha' }

      it "is true" do
        expect {
          subject
        }.not_to raise_error
      end
    end

    context 'when beta' do
      let(:track) { 'beta' }

      it "is true" do
        expect {
          subject
        }.not_to raise_error
      end
    end

    context 'when rollout' do
      let(:track) { 'rollout' }

      it "is true" do
        expect {
          subject
        }.not_to raise_error
      end
    end

    context 'when production' do
      let(:track) { 'production' }

      it "is true" do
        expect {
          subject
        }.not_to raise_error
      end
    end

    context 'when invalid' do
      let(:track) { 'something else' }

      it "is false" do
        expect {
          subject
        }.to raise_error PlayTime::Track::InvalidTrack
      end
    end
  end
end
