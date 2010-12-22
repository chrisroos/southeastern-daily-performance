var FusionApiUrl  = 'http://www.google.com/fusiontables/api/query?sql=';
var FusionTableID = 359310;

var resetRawQuery = function() {
  $('#rawQuery').val('SELECT * FROM ' + FusionTableID + ' LIMIT 5');
}

$(function() {
  resetRawQuery();
  
  $('#queryReset').click(resetRawQuery);
  
  $('#queryEncoder').click(function() {
    $('#queryResults').remove();
        
    var rawQuery     = $('#rawQuery').val();
    var escapedQuery = encodeURIComponent(rawQuery);
    var url          = FusionApiUrl + escapedQuery;
    
    var anchor = $('<a href="' + url + '" target="_blank">View results as CSV</a>');
    $('#escapedQuery').html(anchor);
    
    var displayResultsInPage = $('#queryResultsInPage').attr('checked');
    if (displayResultsInPage) {
      var loading = $('<p>Loading...</p>');
      $('#escapedQuery').after(loading);
      $.getJSON(url + '&jsonCallback=?', function(data) {
        buildResultsTable(data, $('#escapedQuery'));
        loading.remove();
      });
    };
  });
  
  $('.query').each(function() {
    $(this).click(function() {
      var querystring = this.search;
      var escapedQuery = querystring.split('sql=')[1];
      var unescapedQuery = decodeURIComponent(escapedQuery);
      $('#rawQuery').val(unescapedQuery);
      return false;
    })
  });
  
})