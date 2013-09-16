require "childsplay/version"
require "childsplay/client"
require "childsplay/donation"
require "childsplay/donor"
require "childsplay/event"

module Childsplay
  def list_endpoints(client)
    client.get('').body
  end
end
