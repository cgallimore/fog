require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'Rackspace::Servers.list_addresses' do
  describe 'success' do

    before(:each) do
      # flavor 1 = 256, image 3 = gentoo 2008.0
      @server_id = servers.create_server(1, 3).body['server']['id']
    end

    after(:each) do
      eventually(128) do
        servers.delete_server(@server_id)
      end
    end

    it "should return proper attributes" do
      actual = servers.list_addresses(@server_id)
      actual['addresses'].should be_a(Hash)
      actual['addresses']['private'].should be_an(Array)
      actual['addresses']['public'].should be_an(Array)
    end

  end
end