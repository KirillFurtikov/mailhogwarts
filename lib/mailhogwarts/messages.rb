module MailHogwarts
  class Messages < Mailer
    def initialize(args)
      super(args.merge(path: '/api/v2/messages'))
    end
  end
end
