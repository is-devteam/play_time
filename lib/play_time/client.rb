require 'google/api_client'

require 'play_time/authorization'
require 'play_time/runner'
require 'play_time/apk'

module PlayTime
  class Client
    TOKEN_URI   = 'https://accounts.google.com/o/oauth2/token'.freeze
    SCOPE       = 'https://www.googleapis.com/auth/androidpublisher'.freeze
    API         = 'androidpublisher'.freeze
    API_VERSION = 'v2'.freeze

    def authorize!
      client.authorization = oauth2_client
      client.authorization.fetch_access_token!
    end

    def commit(track)
      create_insert
      upload_apk
      update_track(track)
      save
    end

    private

    attr_reader :edit_id

    def create_insert
      @edit_id = Runner.run!(client, api_method: service.edits.insert, parameters: parameters).data.id
    end

    def upload_apk
      upload_params = parameters.merge(editId: edit_id, uploadType: 'media')
      Runner.run! client, api_method: service.edits.apks.upload, parameters: upload_params, media: Apk.load
    end

    def update_track(track)
      update_params = parameters.merge(editId: edit_id, track: track)
      Runner.run! client, api_method: service.edits.tracks.update, parameters: update_params
    end

    def save
      commit_params = parameters.merge(editId: edit_id)
      Runner.run! client, api_method: service.edits.commit, parameters: commit_params
    end

    def parameters
      {package_name: PlayTime.configuration.package_name}
    end

    def client
      @client ||= Google::APIClient.new(
        application_name: PlayTime.configuration.client_name,
        application_version: PlayTime.configuration.client_version
      )
    end

    def service
      @service ||= client.discovered_api(API, API_VERSION)
    end

    def oauth2_client
      @oauth2_client ||= Signet::OAuth2::Client.new(
        token_credential_uri: TOKEN_URI,
        audience: TOKEN_URI,
        scope: SCOPE,
        issuer: PlayTime.configuration.issuer,
        signing_key: openssl_key
      )
    end

    def openssl_key
      @openssl_key ||= Google::APIClient::KeyUtils.load_from_pkcs12(PlayTime.configuration.secret_path, PlayTime.configuration.secret_passphrase)
    end
  end
end
