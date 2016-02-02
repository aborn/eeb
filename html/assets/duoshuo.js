$(function(){
    var data_thread_key = $('.ds-thread').attr('data-thread-key');
    var short_name = $('.ds-thread').attr('short-name');
    console.log("short_name=" + short_name + "  data_thread_key=" + data_thread_key);
    if (data_thread_key != undefined && data_thread_key != '') {
        var url = 'http://api.duoshuo.com/threads/counts.jsonp';
        var data = {
            short_name : short_name,
            threads    : data_thread_key
        };
        $.ajax({
            url : url,
            type : 'GET',
            data : data,
            success : function(data) {
                // console.log(JSON.stringify(data));
                if (data.code == 0) {
                    var dataJson = data.response[data_thread_key];
                    var comments = dataJson.comments;
                    if (comments > 0) {
                        var comments_info = "总共" + comments + "条评论";
                        $('#span-comments').html(comments_info);
                    }
                    var likes = dataJson.likes;
                    if (likes > 0) {
                        var like_info = "获得了" + likes + "个喜欢";
                        $('#span-like').html(like_info);
                    }
                    console.log('likes:' + likes + " comments:" + comments);
                }
            },
            dataType : 'JSONP'})
    }
})
