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

  describe ".suggestions" do
    it "retrieves the list of connection suggestions" do
      stub_ribose_suggestion_list_api
      suggestions = Ribose::Connection.suggestions

      expect(suggestions.first.id).not_to be_nil
      expect(suggestions.first.name).to eq("Jennie Doe")
    end
  end

  describe ".disconnect" do
    it "disconnect with provided connection" do
      connection_id = 123_456
      stub_ribose_connection_delete_api(connection_id)

      expect do
        Ribose::Connection.disconnect(connection_id)
      end.not_to raise_error
    end
  end
end
