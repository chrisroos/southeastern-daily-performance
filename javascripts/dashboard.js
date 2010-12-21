$(function() {
  $('.query').hide();
  
  var p = $('<p>');
  var a = $('<a href="">Toggle queries</a>');
  a.click(function() {
    $('.query').toggle();
    $('pre').toggle();
    return false;
  });
  p.append(a);
  $('h1').after(p);
  
  $('.query').each(function() {
    var queryAnchor    = $(this);
    var queryTitle     = queryAnchor.text();
    var escapedQuery   = this.search.split('?sql=')[1];
    var unescapedQuery = decodeURIComponent(escapedQuery);
    var url            = queryAnchor.attr('href');
  
    var h2      = $('<h2>' + queryTitle + '</h2>');
    var pre     = $('<pre>' + unescapedQuery + '</pre>');
    var loading = $('<p>Loading...</p>');
    pre.hide();
    queryAnchor.before(h2);
    queryAnchor.before(pre);
    queryAnchor.before(loading);
    
    $.getJSON(url + '&jsonCallback=?', function(data) {
      buildResultsTable(data, queryAnchor);
      loading.remove();
    });
  });

});