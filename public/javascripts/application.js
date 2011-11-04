function do_search_post(type){
    if(type == "Author" || type == "Text"){
        qf = $('#query').val();
        window.location.replace("/posts?type="+type+"&query_field="+qf);
    }else{
        start = $('#from_date').val();
        to  = $('#to_date').val();
        window.location.replace("/posts?type="+type+"&query_field1="+start+"&query_field2="+to);
    }
//    
}