require 'rest-client'
require 'json'
require 'base64'
require 'yaml'

require_relative 'mailhogwarts/version'
require_relative 'mailhogwarts/mailer'
require_relative 'mailhogwarts/messages'
require_relative 'mailhogwarts/message'
require_relative 'mailhogwarts/search'

module MailHogwarts
  def self.messages(args)
    @messages = Messages.new(url: args[:url])
  end

  def self.search(url, kind, query)
    @search = Search.new(url: url, kind: kind, query: query)
  end
end
