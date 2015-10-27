require 'rest-client'
require 'json'

module API
  class Testrun

    def initialize(api_key, testmunk_app)
      @api_key = api_key
      @testmunk_app = testmunk_app
    end

    def create(build_path, tests_path, email, public=false, auto_start=true)
      payload = {
          :multipart => true,
          :file => File.new(build_path, 'rb'),
          :testcases => File.new(tests_path, 'rb'),
          :email => email,
          :autoStart => auto_start,
          :public => public
      }

      call('', :post, payload)
    end

    def wait_to_finish(testrun_id, timeout_in_minutes)
      Timeout.timeout(timeout_in_minutes.to_i*60) do
        status = info(testrun_id)['status']
        until status == 'Success' || status == 'Skipped' || status == 'Failed'
          sleep 30
          status = info(testrun_id)['status']
        end
      end
    end

    def info(testrun_id)
      call("/#{testrun_id}")
    end

    def results(testrun_id)
      info(testrun_id)['counts']
    end

    private

    def call(endpoint, method=:get, payload=nil)
      request = RestClient::Request.new(
          :method => method,
          :url => "https://#{@api_key}@api.testmunk.com/apps/#{@testmunk_app}/testruns#{endpoint}",
          :payload => payload,
          :headers => {
              :Accept => 'application/vnd.testmunk.v1+json'
          })

      JSON.parse(request.execute)
    end
  end
end