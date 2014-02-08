$(function(){
  var url = '/sakkotan?callback=?';

  $('#SakkoTan').submit(function(e){
    e.preventDefault();
    var self = this;
    $('.result', self).html('');
    if (this.text.value==''){ return; }
    $.getJSON(url, { str: this.text.value }, function(json){
      $('.result', self).html(json.sakkotan);
    });
  });
});
