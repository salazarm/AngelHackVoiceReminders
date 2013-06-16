var VoiceRecording = function() {
	var add_voice_recording = function(params, callbacks) {
		callbacks = callbacks || {}
		$.ajax({
			type: "POST",
			url: "/reminders",
			data: {
				reminder : {
					name: params['name'],
					file: params['url'],
					message: params['message'],
					description: params['description'],
					playtime: params['playtime'],
					_type: params['type'],
					gender: params['gender']
				},
			},
			success : function(data, status, jqXHR) {
				if (callbacks['success'])
					callbacks['success'](data);
			},
			error: function(error, something, justqXHR) {
				if (callbacks['error'])
					callbacks['error'](error);
			}
		});
	}

	return add_voice_recording
};

window.view_helper = {
	pretty_date : function(date_str) {
	  var seconds = this.get_seconds(date_str) - 60*60*4;
	  var token = 'ago';
	  list_choice = 1;
	  if (seconds < 0) {
	      seconds = Math.abs(seconds);
	      token = 'from now';
	      list_choice = 2;
	  }
	  var i = 0,
	      format;
	  while (format = this.time_formats[i++]) {
	    if (seconds < format[0]) {
	      if (typeof format[2] == 'string') { 
	        return format[list_choice];
	      } else { 
	        if (format[1] == 'just now') {
	          return Math.floor(seconds / format[2]) + ' seconds '+ ' ' + token;
	        }
	        return Math.floor(seconds / format[2]) + ' ' + format[1] + ' ' + token;
	      }
	    }
	  }
	  return time;
	},

	time_formats : [
    [60, 'just now', 1], // 60 
    [120, '1 minute from now', '1 minute ago'], // 60*2
    [3600, 'minutes', 60], // 60*60, 60
    [7200, '1 hour from now', '1 hour ago'], // 60*60*2 
    [86400, 'hours', 3600], // 60*60*24, 60*60 
    [172800, 'yesterday', 'tomorrow'], // 60*60*24*2 
    [604800, 'days', 86400], // 60*60*24*7, 60*60*24 
    [1209600, 'last week', 'next week'], // 60*60*24*7*4*2 
    [2419200, 'weeks', 604800], // 60*60*24*7*4, 60*60*24*7 
    [4838400, 'last month', 'next month'], // 60*60*24*7*4*2 
    [29030400, 'months', 2419200], // 60*60*24*7*4*12, 60*60*24*7*4 
    [58060800, 'last year', 'next year'], // 60*60*24*7*4*12*2 
    [2903040000, 'years', 29030400], // 60*60*24*7*4*12*100, 60*60*24*7*4*12 
    [5806080000, 'last century', 'next century'], // 60*60*24*7*4*12*100*2 
    [58060800000, 'centuries', 2903040000] // 60*60*24*7*4*12*100*20, 60*60*24*7*4*12*100
	],

	get_seconds : function(date_str) {
    var time = new Date(Date.parse(date_str));
    var seconds = ((new Date).getTime() - (new Date(time)).getTime()) / 1000;
    // Quick timezone hack for this submission while I figure out how to
    // fix this issue.
    seconds += 60*60*4 -200200;
    return seconds;
  }
}