// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import $ from "jquery";

// ...

function show_time(ev) {
  let btn = $(ev.target);
  let issue_id = btn.data('issue-id');
  createtime(issue_id);
}

function createtime(issue_id) {
  let text = JSON.stringify({
    time: {
            start: new Date(),
            end: new Date(),
            issue_id: issue_id
      },
  });

  $.ajax(time_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { console.log(resp) },
    error: (resp) => { console.log(resp) },
  });
}

function start_time(ev) {
  let btn = $(ev.target);
  let issue_id = btn.data('issue-id');
  let time_id = btn.data('time-id');
  starts(issue_id,time_id);
}

function starts(issue_id, time_id) {
  let text = JSON.stringify({
    time: {
            id: time_id,
            start: new Date(),
            issue_id: issue_id
      },
  });

  $.ajax(time_path,+ '/'+time_id, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { console.log(resp) },
    error: (resp) => { console.log(resp) },
  });
}


function end_time(ev) {
  let btn = $(ev.target);
  let time_id = btn.data('time-id');
  let issue_id = btn.data('issue-id');
  update(time_id, issue_id);
}

function update(time_id, issue_id) {
  let text = JSON.stringify({
    time: {
            id: time_id,
            end: new Date(),
            issue_id: issue_id
      },
  });

  $.ajax(time_path, + "/"+time_id, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { console.log(resp) },
    error: (resp) => { console.log(resp) },
  });
}

function delete_time(ev) {
  let btn = $(ev.target);
  let time_id = btn.data('time-id');
  delete_rec(time_id);
}

function delete_rec(time_id) {

  $.ajax(time_path, + "/"+time_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: '',
    success: (resp) => { console.log(resp) },
    error: (resp) => { console.log(resp) },
  });
}

function init_time() {
  $(".timeblocks").click(show_time);
  $(".start-button").click(start_time);
  $(".end-button").click(end_time);
  $(".delete-button").click(delete_time);
}

$(init_time);
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
