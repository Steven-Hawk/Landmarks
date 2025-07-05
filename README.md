# Landmarks
Test iOS application.

This project loads landmark data from the bundled JSON file on launch and then
attempts to update that data using the U.S. National Park Service public API.
Provide your API key in the `NPS_API_KEY` environment variable when running the
app to enable live data. If no key is provided the app keeps using the bundled
landmarks and `NPSService.fetchLandmarks()` throws `NPSError.missingAPIKey`.
