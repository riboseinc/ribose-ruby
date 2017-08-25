require "spec_helper"

RSpec.describe Ribose::Widget do
  describe ".all" do
    it "retrieves the list of widgets" do
      stub_ribose_widget_list_api
      widgets = Ribose::Widget.all

      expect(widgets.first.id).not_to be_nil
      expect(widgets.first.status).to eq("loaded")
      expect(widgets.first.type).to eq("Widget::RssFeed")
    end
  end
end
