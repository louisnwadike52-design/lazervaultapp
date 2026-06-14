// Firebase Cloud Messaging service worker for web push.
// This script is loaded by the browser when the FCM JS SDK calls
// `getToken({ serviceWorkerRegistration })`. It must live at the
// app root (/firebase-messaging-sw.js) so the SDK can find it.
//
// The firebaseConfig values below are the *Web* app config. They are not
// secret — they identify the project to Firebase and are bound to the
// origin's domain in the Firebase console.
importScripts('https://www.gstatic.com/firebasejs/10.13.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.13.0/firebase-messaging-compat.js');

// The dev project's web app config is the safe default for a service worker
// served from any non-prod origin. Production deploys overwrite this file at
// build time (fastlane / CI) with the prod config.
firebase.initializeApp({
  apiKey: 'AIzaSyBnwjhqLSi7PJGPViP6HPrnljU96qvXjhg',
  authDomain: 'lazervault-dev.firebaseapp.com',
  projectId: 'lazervault-dev',
  storageBucket: 'lazervault-dev.firebasestorage.app',
  messagingSenderId: '961906506476',
  appId: '1:961906506476:web:e45eeb296e92e41b3843c9',
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  const title = payload.notification?.title || 'LazerVault';
  const options = {
    body: payload.notification?.body || '',
    icon: '/icons/Icon-192.png',
    data: payload.data || {},
  };
  self.registration.showNotification(title, options);
});
