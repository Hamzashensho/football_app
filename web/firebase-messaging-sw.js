importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyBQnnqmOtCKDxID-0OGmfT_GTrFDI4guwo",
   authDomain: "futzone-2b282.firebaseapp.com",
   projectId: "futzone-2b282",
   storageBucket: "futzone-2b282.firebasestorage.app",
   messagingSenderId: "705898564069",
   appId: "1:705898564069:web:165f89755ac214e722870c",
});

const messaging = firebase.messaging();


messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
      };

    return self.registration.showNotification(notificationTitle, notificationOptions);
});