# TrackListDetailApp

TrackListDetailApp is master-detail application that containsa a list of items obtained from a iTunes Search API and show a detailed view of each item. 

The URL that the data was obtained from is as follows: <i>https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all</i>

The list contains details such as Track Name, Artwork, Price, Genre and etc. While details screen has long description for the given item.

<i><b>Architecture: MVVM</b></i>

I opted to use MVVM, given I have limited time for this Coding Challenge, I wanted to determine if I'm comfortable enough to use this whenever I start a new coding project. I still don't if I did completely right, but there was an attempt.

Instead of MVC, using MVVM provided a much cleaner code, and handling better logics and much transparent communication between the Controllers, Views and Models.

It was also mentioned that one benefit of MVVM is improved testability of view controllers. The VCs no longer depends on the model layer, which makes them easier to test. 

<i><b>Persistence: Add to Favorites</b></i>

For the persistence requirement, I added an "Add To Favorites" button represented by the heart button. Once clicked, the selected item/track will be added to favorites by saving a bool value using the Track Name as key.

Once added to favorite, in the list view screen, the heart will be displayed near the image of the item in the favorited.

If the application is closed then restored, the heart in the list view must be visible if added to favorites.
