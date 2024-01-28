// Latest version of Workbox
importScripts(
  "https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js",
);

// Workbox modules
const { CacheFirst, NetworkFirst } = workbox.strategies;
const { registerRoute, setCatchHandler } = workbox.routing;
const { warmStrategyCache } = workbox.recipes;

// Event listeners
self.addEventListener("install", onInstall);
self.addEventListener("activate", onActivate);
self.addEventListener("fetch", onFetch);

// Cache
const documentCache = "documents";
const assetsCache = "assets-styles-and-scripts";
const imagesCache = "assets-images";

const urls = ["/offline.html"];

// Event handlers
function onInstall(event) {
  console.log("[Service Worker]", "Installing!", event);
}

function onActivate(event) {
  console.log("[Service Worker]", "Activating!", event);
}

function onFetch(event) {
  console.log("[Service Worker]", "Fetching!", event);
}

// Cache strategies and routes
registerRoute(
  ({ request, url }) =>
    request.destination === "document" || request.destination === "",
  new NetworkFirst({
    cacheName: documentCache,
  }),
);

registerRoute(
  ({ request }) =>
    request.destination === "script" || request.destination === "style",
  new CacheFirst({
    cacheName: assetsCache,
  }),
);

registerRoute(
  ({ request }) => request.destination === "image",
  new CacheFirst({
    cacheName: imagesCache,
  }),
);

// Offline fallback
const strategy = new CacheFirst();

warmStrategyCache({ urls, strategy });

setCatchHandler(async ({ event }) => {
  switch (event.request.destination) {
    case "document":
      return strategy.handle({
        event,
        request: urls[0],
      });
    default:
      return new Response("Not Found", {
        status: 404,
        statusText: "Not Found",
      });
  }
});
