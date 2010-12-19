var buildResultsTable = function(data, appendTo) {
  // Build the table
  var table = $('<table id="queryResults">');
  appendTo.after(table);

  // Populate the headers
  var tableHeader = $('<thead>');
  var tableRow    = $('<tr>');
  $(data.table.cols).each(function(columIndex, columnName) {
    var tableData = $('<th>' + columnName + '</th>');
    tableRow.append(tableData);
  });
  tableHeader.append(tableRow);
  $(table).append(tableHeader);

  // Populate the data
  var tableBody = $('<tbody>');
  $(data.table.rows).each(function(rowIndex, rowValues) {
    var tableRow = $('<tr>');
    $(rowValues).each(function(columnIndex, columnValue) {
      var tableData = $('<td>' + columnValue + '</td>');
      tableRow.append(tableData);
    });
    tableBody.append(tableRow);
  });
  $(table).append(tableBody);
};