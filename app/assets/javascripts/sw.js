console.log('Started', self);
self.addEventListener('install', function(event) {
  self.skipWaiting();
  console.log('Installed', event);
});
self.addEventListener('activate', function(event) {
  console.log('Activated', event);
});
self.addEventListener('push', function(event) {
  if (event.data) {
    var json = event.data.json();
    self.registration.showNotification(json.title, json);
  }
});
self.addEventListener('notificationclick', function(event) {
  console.log('Notification click: tag ', event.notification.tag);
  event.notification.close();

  var action = event.action || 'open-app';

  var url = false;

  if (action === 'open-app') {
    url = '//glassycollections.com/';
  } else if (action === 'record-pendant') {
    url = '//glassycollections.com/my/pendant_records/new';
  }

  if (url) {
    event.waitUntil(clients.matchAll({
          includeUncontrolled: true,
          type: 'window'
        }).then(
        function(activeClients) {
          if (activeClients.length > 0) {
            activeClients[0].navigate(url);
            activeClients[0].focus();
          } else {
            clients.openWindow(url);
          }
        })
    );
  }
});
