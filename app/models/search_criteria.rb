class SearchCriteria 
  attr_accessor :body, :conversation_id
  def initialize(options =  nil)
    self.body = options[:body] if options
    self.conversation_id = options[:conversation_id] if options
  end
end
