module PostsHelper
  def show_query_field(type, value1, value2)
    case type.capitalize
    when "Author"
      query_type = text_field_tag "query_field1", value1, :id => "query", :style => "width:200px"
    when "Text"
      query_type = text_field_tag "query_field1", value1, :id => "query", :style => "width:200px"
    when "Date"
      query_type = text_field_tag "query_field2", value2, :id => "to_date", :style => "width:100px"
      query_type += content_tag(:span, "To", :class => "text_to")
      query_type += text_field_tag "query_field1", value1, :id => "from_date", :style => "width:100px"
      query_type += javascript_tag "$(function() {$( '#from_date' ).datepicker({ dateFormat: 'yy-mm-dd' });$('#to_date').datepicker({ dateFormat: 'yy-mm-dd' });});"
    when "Tag"
      query_type = text_field_tag "query_field1", value1, :id => "query", :style => "width:200px"
    when "Category"
      query_type = text_field_tag "query_field1", value1, :id => "query", :style => "width:200px"
    end
    query_type
  end
  
end
