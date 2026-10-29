/**
 * Google Apps Script for "Student Marks Viewer" Mobile Application
 * Subject: Digital Literacy and Application (Unit 6, Activity 6)
 * Department: Robotics and Automation
 */

function doGet(e) {
  try {
    var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
    var data = sheet.getDataRange().getValues();

    if (!data || data.length < 2) {
      return createJsonResponse({ status: "success", count: 0, data: [] });
    }

    var headers = data[0].map(function(header) { return String(header).trim(); });
    var students = [];

    for (var i = 1; i < data.length; i++) {
      var row = data[i];
      var isEmpty = row.every(function(cell) { return cell === "" || cell === null; });
      if (isEmpty) continue;

      var studentObj = {};
      for (var j = 0; j < headers.length; j++) {
        var key = headers[j];
        var val = row[j];
        if (key === "10th" || key === "12th" || key === "Sem 1" || key === "Sem 2") {
          studentObj[key] = (val === "" || val === null || isNaN(Number(val))) ? 0 : Number(val);
        } else {
          studentObj[key] = val !== null && val !== undefined ? String(val).trim() : "";
        }
      }

      if (studentObj["Roll No"] || studentObj["Student Name"]) {
        students.push(studentObj);
      }
    }

    return createJsonResponse({ status: "success", count: students.length, data: students });
  } catch (error) {
    return createJsonResponse({ status: "error", message: error.toString(), data: [] });
  }
}

function createJsonResponse(payload) {
  return ContentService.createTextOutput(JSON.stringify(payload)).setMimeType(ContentService.MimeType.JSON);
}
