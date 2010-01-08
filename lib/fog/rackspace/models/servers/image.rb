module Fog
  module Rackspace
    class Servers

      class Image < Fog::Model

        identity :id

        attribute :name
        attribute :created_at,  'created'
        attribute :updated_at,  'updated'
        attribute :status
        attribute :server_id,   'serverId'

        def server=(new_server)
          requires :id

          @server_id = new_server.id
        end

        def destroy
          requires :id

          connection.delete_image(@id)
          true
        end

        def save
          requires :server_id

          data = connection.create_server(@server_id)
          merge_attributes(data.body['image'])
          true
        end

      end

    end
  end
end
