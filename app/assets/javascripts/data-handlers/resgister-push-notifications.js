(function() {
    var sendSubscriberIdToServer = function(subscriber_id) {
        console.log('subscriber_id:', subscriber_id);
    };

    var registerPushNotifications = function(e) {
        if ('serviceWorker' in navigator) {
            console.log('Service Worker is supported');
            navigator.serviceWorker.register('/sw.js').then(function(sreg) {
                console.log(':^)', sreg);
                navigator.serviceWorker.ready.then(function (reg) {
                    reg.pushManager.subscribe({
                        userVisibleOnly: true
                    }).then(function (sub) {
                        var subscriber_id = _.last(_.split(sub.endpoint, '/'));
                        sendSubscriberIdToServer(subscriber_id);
                    });
                }).catch(function (error) {
                    console.log(':^(', error);
                });
            });
        }
    };

    $(document).on('click', '[data-register-push-notifications]', registerPushNotifications);
})();
