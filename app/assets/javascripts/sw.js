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
        self.registration.showNotification(json.title, {
            body: json.body,
            icon: json.icon
        });
    }
});
self.addEventListener('notificationclick', function(event) {
    console.log('Notification click: tag ', event.notification.tag);
    event.notification.close();
    var url = 'https://www.google.com/';
    if (clients.openWindow) {
        return clients.openWindow(url);
    }
});
