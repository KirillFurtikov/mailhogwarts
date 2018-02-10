module MailHogwarts
  class Search < Mailer
    def initialize(args)
      super(args.merge(path: "/api/v2/search?kind=#{args[:kind]}&query=#{args[:query]}"))
    end
  end
end
