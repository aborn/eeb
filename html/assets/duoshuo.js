$(function(){
    var data_thread_key = $('.ds-thread').attr('data-thread-key');
    var short_name = $('.ds-thread').attr('short-name');
    console.log("short_name=" + short_name + "  data_thread_key=" + data_thread_key);
    if (data_thread_key != undefined && data_thread_key != '') {
        var url = 'http://api.duoshuo.com/threads/counts.jsonK';
        var data = {
            short_name : short_name,
            threads    : data_thread_key
        };
        $.get(url, data, function(data) {
            console(JSON.stringify(data));
            var dataJson = data[data_thread_key];
        },'json');
    }
})
