$("input.datepicker").datepicker(
  {
    changeMonth: true,
    changeYear: true,
    dateFormat: 'mm/dd/yy'
  }
  );
$.PeriodicalUpdater('/messages/notifications', {
  method: 'get', // method; get or post
  data: '1', // array of values to be passed to the page - e.g. {name: "John", greeting: "hello"}
  minTimeout: 3000, // starting value for the timeout in milliseconds
  maxTimeout: 8000, // maximum length of time between requests
  multiplier: 2, // the amount to expand the timeout by if the response hasn't changed (up to maxTimeout)
  type: '', // response type - text, xml, json, etc. See $.ajax config options
  maxCalls: 0, // maximum number of calls. 0 = no limit.
  autoStop: 0 // automatically stop requests after this many returns of the same data. 0 = disabled.
}, function(remoteData, success, xhr, handle) {
  // Process the new data (only called when there was a change)
});