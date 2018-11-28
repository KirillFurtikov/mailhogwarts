module MailHogwarts
  class Message
    class Body
      attr_accessor :body

      def initialize(string)
        @body = String.new(string)
      end

      def to_html
        Nokogiri::HTML(@body)
      end

      def links(expression = '')
        urls = to_html.css('a').map do |link|
          {
            href: link['href'],
            text: link.text,
            html: link.to_html
          }
        end

        if expression.is_a? Regexp
          urls.reject do |link|
            string = link[:href][expression]
            string.nil? || string.empty?
          end
        elsif expression.is_a? String
          urls.select { |link| link[:href].include? expression }
        end
      end
    end
  end
end
