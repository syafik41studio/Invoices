module PostsHelper
  def display_categories(post,categories)
    ret = "<ul>"
    for category in categories
      if category.parent_id.eql?(nil)
        ret += "<li id='#{category.id}'>"
        ret += check_box_tag "post[post_category_ids][]", category.id, post.post_categories.include?(category)
        ret += "  #{category.name}"
        ret += find_all_subcategories(post,category) 
        ret += "</li>"
      end
    end
    ret += "</ul>"
  end

  def find_all_subcategories(post,category)
    ret = '<ul>'
    if category.children.size > 0
      category.children.each { |subcat|
        if subcat.children.size > 0
          ret += '<li>'
          ret += check_box_tag "post[post_category_ids][]", subcat.id, post.post_categories.include?(subcat)
          ret += "  #{subcat.name}"
          ret += find_all_subcategories(post,subcat)
          ret += '</li>'
        else
          ret += '<li>'
          ret += check_box_tag "post[post_category_ids][]", subcat.id, post.post_categories.include?(subcat)
          ret += "  #{subcat.name}"
          ret += '</li>'
        end
      }
    end
    ret += '</ul>'
  end

  def show_query_field(type, value)
    case type
    when "author"
      query_type = text_field_tag "query_field", value, :id => "query", :style => "width:200px"
    when "text"
      query_type = text_field_tag "query_field", value, :id => "query", :style => "width:200px"
    when "date"
      query_type = text_field_tag "query_field", value, :id => "from_date", :style => "width:100px"
      query_type += content_tag(:span, "To", :class => "text_to")
      query_type += text_field_tag "query_field", value, :id => "to_date", :style => "width:100px"
      query_type += javascript_tag "$(function() {$( '#from_date' ).datepicker();$('#to_date').datepicker();});"
    end
    query_type
  end
  
end
