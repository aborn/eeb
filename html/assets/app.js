$(document).ready(function() {
    $('pre code').each(function(i, block) {
        hljs.highlightBlock(block);
    });
});


$('.menu .item').tab();

/*$('.blog-list li').map(function(currentValue, index){
 console.log('ooooo')
 });*/

var DateDiff = {

    inMinutes: function(d1, d2) {
        var t2 = d2.getTime();
        var t1 = d1.getTime();
        return parseInt((t2 - t1)/(60*1000))
    },

    inHours: function(d1, d2) {
        var t2 = d2.getTime();
        var t1 = d1.getTime();
        return parseInt((t2 - t1)/(3600*1000))
    },

    inDays: function(d1, d2) {
        var t2 = d2.getTime();
        var t1 = d1.getTime();

        return parseInt((t2-t1)/(24*3600*1000));
    },

    inWeeks: function(d1, d2) {
        var t2 = d2.getTime();
        var t1 = d1.getTime();

        return parseInt((t2-t1)/(24*3600*1000*7));
    },

    inMonths: function(d1, d2) {
        var d1Y = d1.getFullYear();
        var d2Y = d2.getFullYear();
        var d1M = d1.getMonth();
        var d2M = d2.getMonth();

        return (d2M+12*d2Y)-(d1M+12*d1Y);
    },

    inYears: function(d1, d2) {
        return d2.getFullYear()-d1.getFullYear();
    },

    getDesc: function(d1, d2) {
        var minutes = this.inMinutes(d1,d2);
        var hours = this.inHours(d1,d2);
        if (minutes < 2) {
            return "刚刚发表";
        } else if (minutes < 60) {
            return  minutes + "分钟之前";
        } else {
            if (hours < 24) {
                return hours + "小时之前";
            } else {
                var days = this.inDays(d1, d2);
                if (days < 30) {
                    return days + "天之前";
                } else {
                    if (d1 instanceof Date) {
                        return  d1.getFullYear() + "-" +
                            (d1.getMonth() + 1) + "-" +
                            (d1.getDay() +1) + " " + d1.toLocaleTimeString();
                    } else {
                        return "发表时间未知!";
                    }
                }
            }
        }
    }
};

function doTimeAction() {
    $('.blog-list li').each(function(){
        var spanPlug = $(this).find('.list-top>span');
        var publishTime = new Date(spanPlug.attr('data-shared-at'));
        var currentTime = new Date();
        spanPlug.html(DateDiff.getDesc(publishTime, currentTime));
    });
}

function timer() {
    doTimeAction();
    setTimeout("timer()",1000);
}

timer();

$('.popup').popup();

// 正文中的图片限制最大宽度
$('body').find('img').each(function(index, value) {
    $(value).css("max-width", "700px");
});
