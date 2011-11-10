function do_search_post(type){
    if(type == "Author" || type == "Text" || type == "Tag" || type == "Category"){
        qf = $('#query').val();
        window.location.replace("/posts?type="+type+"&query_field1="+qf);
    }else{
        start = $('#from_date').val();
        to  = $('#to_date').val();
        window.location.replace("/posts?type="+type+"&query_field1="+start+"&query_field2="+to);
    }
//    
}