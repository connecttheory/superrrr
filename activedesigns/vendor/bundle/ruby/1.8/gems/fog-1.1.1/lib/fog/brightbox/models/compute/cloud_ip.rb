require 'fog/core/model'

module Fog
  module Compute
    class Brightbox

      class CloudIp < Fog::Model

        identity :id
        attribute :url
        attribute :resource_type

        attribute :name
        attribute :status
        attribute :description

        attribute :reverse_dns
        attribute :public_ip

        # Links - to be replaced
        attribute :account_id, :aliases => "account", :squash => "id"
        attribute :interface_id, :aliases => "interface", :squash => "id"
        attribute :server_id, :aliases => "server", :squash => "id"
        attribute :load_balancer, :alias => "load_balancer", :squash => "id"

        def map(interface_to_map)
          requires :identity
          connection.map_cloud_ip(identity, :interface => interface_to_map)
        end

        def mapped?
          status == "mapped"
        end

        def unmap
          requires :identity
          connection.unmap_cloud_ip(identity)
        end

        def destroy
          requires :identity
          connection.destroy_cloud_ip(identity)
        end

      end

    end
  end
end
