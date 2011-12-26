config.wrappers :placeholder => false, :hint => false do |b|
  b.use :placeholder
  b.use :label_input
  b.use :tag => :div, :class => "separator" do |ba|
    ba.use :hint,  :tag => :span, :class => :hint
    ba.use :error, :tag => :span, :class => :error
  end
end
