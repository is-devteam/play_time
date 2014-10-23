describe PlayTime, if: PlayTime.config_path.end_with?('default.yml') do
  describe '.configuration' do
    subject { PlayTime.configuration }

    it 'provides a nice getter for the app id' do
      expect(subject.app_id).to eq 'app id'
    end
  end
end
