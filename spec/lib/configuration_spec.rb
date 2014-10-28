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

  describe '.exists?' do
    before do
      allow(File).to receive(:exist?).and_return(true)
      allow(PlayTime).to receive(:config_path).and_return('/path')
    end

    it 'delegates to file' do
      PlayTime::Configuration.exists?

      expect(File).to have_received(:exist?).with('/path')
    end
  end

  describe '.create_config' do
    let(:config_path) { '/config/path.yml' }
    let(:config_dir) { '/config/dir' }

    subject { PlayTime::Configuration.create_config(config_dir, config_path) }

    before do
      allow(FileUtils).to receive(:mkdir_p)
    end

    context 'when config dir exists' do
      before do
        allow(File).to receive(:exist?).and_return(true)
      end

      it 'does not create a config dir' do
        expect(FileUtils).not_to have_received(:mkdir_p).with(config_dir)
      end
    end

    context 'when config dir does not exist' do
      before do
        allow(File).to receive(:exist?).and_return(false)
      end
    end
  end
end
