# TMDBApp Coding Task

## app requirements
- Content should be backend driven. You can host one / more json file/s on gist.github.com or any other service and use it as the host of the data from your app (or any online REST alternative). Pagination should be implemented.
- Use grids / lists displaying list of items. Each cell should consist of a backend driven image and title. After tapping, selected content should be shown on the details screen with more information. Extra point might be to present an additional screen modally.
- Possibility to mark the item as “favourite” and filter the list to show only favourite items.
- There should be a mechanism to persist favourites between app launches. You don’t have to persist whole objects – implementation is up to you. You may use UserDefaults but make it scalable.
- Have a point of synchronisation (e.g. making two concurrent network requests and waiting for both of them to finish).
- Handle loading and error states

## technical requirements
- The app should be written using SwiftUI language
- App can support phones only (no need to support iPad)
- 3rd-party frameworks are not allowed
- Store data on Popular Movies and Movie Details screens in permanent storage (available offline)
- Clean code with production grade coding style
- We do not enforce any design pattern – use whatever you think suits your project best.
- Make sure your code is testable
- README explaining how to run the project
- Extra tasks:
 - Unit tests
 - UI tests
 - Save Search Screen results in permanent storage

## Required tasks:
- Popular Movies screen: It will be the first screen with a list of popular movies with pagination. From this screen the user can perform Search and toggle filtering of favourite movies. Show these fields:
 - title
 - posterImage(poster_path)
- Search: When user types search is automatically performed. Show these fields:
 - title
 - posterImage(poster_path)
- Movie Details screen: When user clicks on the movie item on the Popular Movies screen or in the Search, app should open Movie Details screen should consist of:
 - data already loaded on the previous screen (title, posterImage). Don't download it again on the details screen.
 - Additional data loaded with two concurrent network requests:
 - overview & release date
 - tappable label showing list of languages (spoken languages). After tapping thr label, a full list of languages should be displayed modally.
 - button to favourite / unfavourite the movie

## requirements
In order to compile and run this app you need to have a Mac running Mac OS Sequoia with Xcode 16.

## how to run
Open TMDBApp.xcodeproj, select prefered simulator and click "Start the active scheme" button.

## author
Tomasz Paluch - paluch.t@wp.pl - for recruitment process at AI Clearing.
