module SearchesHelper
  def render_query_form
   if @search.new_record?
      form_path = searches_path
    else
      form_path = search_path
    end
    render :partial => 'searches/partial/form', :locals => {:form_path => form_path}
  end
end
