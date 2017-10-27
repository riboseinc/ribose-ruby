require "json"
require "mechanize"
require "ribose/config"

module Ribose
  class Session
    def initialize(username, password)
      @username = username
      @password = password
    end

    def create
      JSON.parse(authenticate_user)
    rescue NoMethodError, JSON::ParserError
      raise Ribose::Unauthorized
    end

    def self.create(username:, password:)
      new(username, password).create
    end

    private

    attr_reader :username, :password

    def authenticate_user
      page = agent.get(ribose_url_for("login"))
      find_and_submit_the_user_login_form(page)
      agent.get(ribose_url_for(["settings", "general", "info"])).body
    end

    def find_and_submit_the_user_login_form(page)
      login_form = page.form_with(id: "new_user")
      login_form.field_with(id: "loginEmail").value = username
      login_form.field_with(id: "loginPassword").value = password

      login_form.submit
    end

    def agent
      @agent ||= Mechanize.new
    end

    def ribose_url_for(*endpoint)
      [Ribose.configuration.web_url, *endpoint].join("/")
    end
  end
end
