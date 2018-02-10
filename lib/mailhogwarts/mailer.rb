module MailHogwarts
  class Mailer
    attr_reader :domain, :url, :path, :body, :messages

    def initialize(args)
      @url = "#{@domain = args[:url]}#{@path = args[:path]}"
    end

    def call
      response = RestClient::Request.execute method: :get, url: @url, verify_ssl: false
      @body = JSON.parse(response.body)

      @messages = body['items'].map do |message|
        Message.new id: message['ID'],
                    created_at: Time.parse(message['Created']).to_i,
                    from: message['Raw']['From'],
                    to: message['Raw']['To'],
                    subject: readable_subject(message['Content']['Headers']['Subject'].join(' ')),
                    body: readable_body(message['Content']['Body'])
      end

      @messages.size
    end

    def [](index)
      @messages[index]
    end

    def ids
      @ids = @messages.map(&:id)
    end

    def count
      body['count']
    end

    def total
      body['total']
    end

    def select(filters)
      messages = @messages
      filtered_messages = []

      (%i[from to subject body] & filters.keys).each do |filter|
        messages.each do |message|
          filtered_messages << message if message.send(filter).include?(filters[filter])
        end

        messages = filtered_messages
        filtered_messages = []
      end

      messages
    end

    private

    def readable_body(body)
      Base64.decode64(body).force_encoding('utf-8')
    end

    def readable_subject(subject)
      subject.split('=?UTF-8?Q?').map do |word|
        next if word.size.zero?

        word.strip.gsub(/(\?=)/, '').tr('_', ' ')
      end.reject(&:nil?).map do |word|
        next if word.nil?

        word.unpack('M').join('')
      end.join('').strip.force_encoding('utf-8')
    end
  end
end
