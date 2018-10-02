App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    $("#notification-data").prepend(data.html);
    $('#notificationList').prepend(data.html);
    this.update_counter(data.counter);
  },

  update_counter: function(counter) {
    $counter = $("#notification-counter");
    val = parseInt($counter.text());
    val++;
    $counter.css({opacity: 0});
    $counter.text(val);
    $counter.css({top: '-10px'});
    $counter.css({top: '-2px', opacity: 1});
  }

});
