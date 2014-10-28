require 'play_time/client'

describe PlayTime::Client do
  let(:api_client) { instance_double(Google::APIClient) }
  let(:oauth2_client) { instance_double(Signet::OAuth2::Client) }

  before do
    allow(PlayTime.configuration).to receive(:client_name).and_return('client_name')
    allow(PlayTime.configuration).to receive(:client_version).and_return('client_version')
    allow(PlayTime.configuration).to receive(:secret_path).and_return('/path/secret.p12')
    allow(PlayTime.configuration).to receive(:secret_passphrase).and_return('p12 secret')
    allow(PlayTime.configuration).to receive(:issuer).and_return('issuer@developer.gserviceaccount.com')

    allow(Google::APIClient).to receive(:new).and_return(api_client)
    allow(Signet::OAuth2::Client).to receive(:new).and_return(oauth2_client)
    allow(api_client).to receive(:authorization=)
    allow(api_client).to receive(:authorization).and_return(oauth2_client)
  end

  describe '#authorize!' do
    let(:key_utils) { instance_double(OpenSSL::PKey) }

    subject { PlayTime::Client.new.authorize! }

    before do
      allow(Google::APIClient::KeyUtils).to receive(:load_from_pkcs12).and_return(key_utils)
      allow(oauth2_client).to receive(:fetch_access_token!)
    end

    it "creates a client" do
      subject

      expect(Google::APIClient).to have_received(:new).with(application_name: 'client_name', application_version: 'client_version')
    end

    it 'creates authorization object' do
      subject

      expect(Google::APIClient::KeyUtils).to have_received(:load_from_pkcs12).with('/path/secret.p12', 'p12 secret')
    end

    it "initializes the oauth client" do
      subject

      expect(Signet::OAuth2::Client).to have_received(:new).with(
        token_credential_uri: PlayTime::Client::TOKEN_URI,
        audience: PlayTime::Client::TOKEN_URI,
        scope: PlayTime::Client::SCOPE,
        issuer: 'issuer@developer.gserviceaccount.com',
        signing_key: key_utils
      )
    end

    it "sets the oauth client on the google client" do
      subject

      expect(api_client).to have_received(:authorization=).with(oauth2_client)
    end

    it "authorizes the oauth client" do
      subject

      expect(oauth2_client).to have_received(:fetch_access_token!)
    end
  end

  describe '#commit' do
    let(:track) { 'alpha' }
    let(:service) { double(Google::APIClient::API) }
    let(:response) { double(:response, data: double(:data, id: 'id', versionCode: 'version code')) }
    let(:apk_file) { instance_double(Google::APIClient::UploadIO) }

    subject { PlayTime::Client.new.commit(track) }

    before do
      allow(PlayTime.configuration).to receive(:package_name).and_return('com.package.name')

      allow(PlayTime::Runner).to receive(:run!).and_return(response)
      allow(PlayTime::Apk).to receive(:load).and_return(apk_file)
      allow(api_client).to receive(:discovered_api).and_return(service)
      allow(service).to receive_message_chain('edits.insert').and_return('insert')
      allow(service).to receive_message_chain('edits.apks.upload').and_return('upload')
      allow(service).to receive_message_chain('edits.tracks.update').and_return('track update')
      allow(service).to receive_message_chain('edits.commit').and_return('commit')
    end

    it 'creates a service' do
      subject

      expect(api_client).to have_received(:discovered_api).with('androidpublisher', 'v2')
    end

    it 'creates an edit' do
      subject

      expect(PlayTime::Runner).to have_received(:run!).with(
        api_client, api_method: 'insert', parameters: { packageName: 'com.package.name' })
    end

    it 'uploads an apk file' do
      subject

      expect(PlayTime::Runner).to have_received(:run!).with(
        api_client,
        api_method: 'upload',
        parameters: { packageName: 'com.package.name', editId: 'id', uploadType: 'media' },
        media: apk_file
      )
    end

    it 'updates a track' do
      subject

      expect(PlayTime::Runner).to have_received(:run!).with(
        api_client,
        api_method: 'track update',
        parameters: { packageName: 'com.package.name', editId: 'id', track: track },
        body_object: { versionCodes: ['version code'] }
      )
    end

    it 'commits the changes' do
      subject

      expect(PlayTime::Runner).to have_received(:run!).with(
        api_client,
        api_method: 'commit',
        parameters: { packageName: 'com.package.name', editId: 'id' }
      )
    end
  end
end
