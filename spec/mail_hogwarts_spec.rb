RSpec.describe MailHogwarts do
  describe 'VERSION' do
    it 'has a version number' do
      expect(MailHogwarts::VERSION).not_to be nil
    end
  end

  it 'respond to messages' do
    expect(MailHogwarts).respond_to?(:messages)
  end
end
