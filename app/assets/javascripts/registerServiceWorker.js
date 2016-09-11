if ('serviceWorker' in navigator) {
    console.log('Service Worker is supported');
    navigator.serviceWorker.register('/sw.js').then(function(sreg) {
        console.log(':^)', sreg);
        navigator.serviceWorker.ready.then(function (reg) {
            reg.pushManager.subscribe({
                userVisibleOnly: true
            }).then(function (sub) {
                console.log('sub:', sub);
                console.log('endpoint:', sub.endpoint);
            });
        }).catch(function (error) {
            console.log(':^(', error);
        });
    });
}
