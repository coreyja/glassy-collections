console.log('Started', self);
self.addEventListener('install', function(event) {
    self.skipWaiting();
    console.log('Installed', event);
});
self.addEventListener('activate', function(event) {
    console.log('Activated', event);
});
self.addEventListener('push', function(event) {
    var title = 'Push message';
    event.waitUntil(
        self.registration.showNotification(title, {
            body: 'The Message',
            icon: 'assets/launcher-icon-4x.png',
            tag: 'my-tag'
        }));
});
self.addEventListener('notificationclick', function(event) {
    console.log('Notification click: tag ', event.notification.tag);
    event.notification.close();
    var url = 'https://www.google.com/';
    if (clients.openWindow) {
        return clients.openWindow(url);
    }
});
