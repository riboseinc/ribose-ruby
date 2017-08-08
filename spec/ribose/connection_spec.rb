require "spec_helper"

RSpec.describe Ribose::Connection do
  describe ".all" do
    it "retrieves the list of connections" do
      stub_ribose_connection_list_api

      connections = Ribose::Connection.all
      first_connection = connections.objects.first

      expect(first_connection.id).not_to be_nil
      expect(first_connection.connection_id).not_to be_nil
      expect(first_connection.data_for_jabber.login).to eq("riboseteam")
    end
  end

  def stub_ribose_connection_list_api
    stub_api_response(:get, "people/connections?s=", filename: "connections")
  end
end
