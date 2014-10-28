describe PlayTime::Runner do
  describe '.run!' do
    let(:response) { double(:response, data: {success: true}) }
    let(:client) { double(:client, execute: response) }
    let(:options) { {foo: :bar} }

    subject { PlayTime::Runner.run!(client, options) }

    it 'executes an api' do
      subject

      expect(client).to have_received(:execute).with(options)
    end

    context 'when success' do
      it 'returns a response' do
        expect(subject).to eq response
      end

      context 'when data is nil' do
        let(:response) { double(:response, data: nil) }

        it 'returns the response' do
          expect(subject).to eq response
        end
      end
    end

    context 'when failure' do
      context 'when data has an error' do
        let(:response) { double(:response, data: {'error' => 'Something went wrong'}) }

        it 'raises an error' do
          expect {
            subject
          }.to raise_error PlayTime::Runner::ResponseError, 'Something went wrong'
        end
      end
    end
  end
end
