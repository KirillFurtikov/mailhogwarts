require_relative 'body'

module MailHogwarts
  class Message
    include Comparable
    attr_reader :message

    def initialize(fields)
      @message = fields
      @message[:body] = Body.new(@message[:body])

      @message.keys.each do |key|
        define_singleton_method(key.to_s) do
          @message[key]
        end
      end
    end

    def keys
      @message.keys
    end

    alias fields keys

    def <=>(other)
      created_at.to_i <=> other.created_at.to_i
    end
  end
end
