require 'play_time/tasks'

describe 'play_time tasks' do
  describe 'upload' do
    shared_examples_for 'upload task' do
      it 'uploads an apk to production' do
        allow(PlayTime).to receive(:upload)

        Rake::Task["play_time:upload:#{track}"].invoke

        expect(PlayTime).to have_received(:upload).with(track)
      end
    end

    PlayTime::Track::TRACKS.each do |track|
      it_behaves_like 'upload task' do
        let(:track) { track }
      end
    end
  end

  describe 'promote' do
    shared_examples_for 'promote task' do
      it 'promotes the version number' do
        allow(PlayTime).to receive(:promote)

        Rake::Task["play_time:promote:#{track}"].invoke("232")

        expect(PlayTime).to have_received(:promote).with(track, 232)
      end
    end

    PlayTime::Track::TRACKS.each do |track|
      it_behaves_like 'promote task' do
        let(:track) { track }
      end
    end
  end

  describe 'install task' do
    let(:config_file) { File.expand_path('config/play_time.yml') }

    before do
      allow(PlayTime).to receive(:config_path).and_return('config/play_time.yml')
      Rake::Task['play_time:install'].reenable
    end

    after do
      File.delete(config_file) if File.exist?(config_file)
    end

    context "when config file doesn't exist" do
      it 'generates an exmaple config file' do
        Rake::Task['play_time:install'].invoke

        expect(File).to exist(config_file)
        expect(open(File.expand_path("lib/play_time/templates/play_time.yml")).read). to eq(open(config_file).read)
      end
    end

    context "when config file already exists" do
      before do
        Rake::Task['play_time:install'].invoke
        Rake::Task['play_time:install'].reenable
      end

      it "doesn't do anything" do
        sleep(0.5)

        expect do
          Rake::Task['play_time:install'].invoke
        end.not_to change { File.open(PlayTime.config_path).mtime }
      end
    end
  end
end
