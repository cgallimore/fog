require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'Rackspace::Servers.create_image' do
  describe 'success' do

    before(:each) do
      # flavor 1 = 256, image 3 = gentoo 2008.0
      @server_id = servers.create_server(1, 3).body['server']['id']
    end

    after(:each) do
      eventually(128) do
        servers.delete_server(@server_id)
      end
      servers.delete_image(@image_id)
    end

    it "should return proper attributes" do
      actual = servers.create_image(@server_id)['image']
      actual['created'].should be_a(Time)
      actual['id'].should be_an(Integer)
      actual['name'].should be_a(String)
      actual['progress'].should be_an(Integer)
      actual['serverId'].should be_an(Integer)
      actual['status'].should be_a(String)
    end

  end
end