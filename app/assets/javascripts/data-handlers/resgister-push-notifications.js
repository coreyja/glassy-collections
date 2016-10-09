(function() {
    var sendDataToServer = function(sub) {
        var url = "/api/my/push_notification_subscriptions";
        var extract = function(key) {
            btoa(String.fromCharCode.apply(null, new Uint8Array(key))).replace(/\+/g, '-').replace(/\//g, '_')
        };
        var data = {
            endpoint: sub.endpoint,
            p256dh: extract(sub.getKey('p256dh')),
            auth: extract(sub.getKey('auth'))
        };

        $.post(url, data, function() {
            console.log('Saved to server!');
        });
    };

    var registerPushNotifications = function(e) {
        if ('serviceWorker' in navigator) {
            console.log('Service Worker is supported');
            navigator.serviceWorker.register('/sw.js').then(function(sreg) {
                console.log(':^)', sreg);
                navigator.serviceWorker.ready.then(function (reg) {
                    reg.pushManager.subscribe({
                        userVisibleOnly: true
                    }).then(sendDataToServer);
                }).catch(function (error) {
                    console.log(':^(', error);
                });
            });
        }

        return false;
    };

    $(document).on('click', '[data-register-push-notifications]', registerPushNotifications);
}());
