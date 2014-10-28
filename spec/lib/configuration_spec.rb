describe PlayTime::Configuration do
  shared_examples_for 'configuration option' do
    let(:configuration) { PlayTime::Configuration.new({option.to_s => option, 'foo' => 'bar'}) }

    subject { configuration.send(option) }

    it "fetchings the option from the config" do
      expect(subject).to eq option
    end

    context 'missing options' do
      let(:configuration) { PlayTime::Configuration.new({'foo' => 'bar'}) }

      it "raises an exception for each missing param" do
        expect {
          subject
        }.to raise_error PlayTime::Configuration::MissingOption, "Missing #{option} in #{PlayTime.config_path}"
      end
    end
  end

  PlayTime::Configuration::OPTIONS.each do |option|
    describe "##{option}" do
      let(:option) { option }

      it_behaves_like 'configuration option'
    end
  end
end
